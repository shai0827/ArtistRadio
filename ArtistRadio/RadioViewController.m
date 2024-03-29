//
//  RadioViewController.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 17..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "RadioViewController.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

@synthesize radioModel;
@synthesize progressUpdateTimer;
@synthesize onload;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //  model
        id appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.radioModel = [appDelegate radioModel];
        [self.radioModel retain];
        
        //  배경 이미지 추가
        UIImageView *background = [ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
        [self.view insertSubview:background atIndex:0];
        [background release];
        background = nil;
        
        //  player view
        playerView = [[PlayerUIView alloc] initWithFrame:[self.radioModel getPlayerViewRect:self.view.frame.size]];
        playerView.delegate = self;
        [self.view addSubview:playerView];
        
        self.radioModel.status = 1;
        
        //  web view
        [self loadWebPage:[self.radioModel getListURL]];
        
        NSLog(@"start");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebPage: (NSString *)url
{
    self.onload = NO;
    [listView stopLoading];
    if (listView != nil) {
        [listView release];
        listView = nil;
    }
    
    if (webRequest != nil) {
        [webRequest release];
        webRequest = nil;
    }
    
    webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    listView = [[UIWebView alloc] initWithFrame:[self.radioModel getListViewRect:self.view.frame.size]];
    listView.delegate = self;
    [self.view addSubview:listView];
    
    [listView loadRequest:webRequest];
    
    [self setScrollViewBackgroundColor:[self.radioModel getBackgroundColor]];
    
//    [listView sizeThatFits:CGSizeZero];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [listView.scrollView setContentSize:CGSizeMake(listView.frame.size.width, listView.frame.size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//    [scrollView setContentOffset:CGPointMake(0, 15)];
}

- (void)setScrollViewBackgroundColor:(UIColor *)color
{
    for (UIView *subview in [listView subviews]) {
        subview.backgroundColor = color;
        for (UIView *shadowView in [subview subviews]) {
            if ([shadowView isKindOfClass:[UIImageView class]]) {
                shadowView.hidden = YES;
            }
        }
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@">> %@", requestString);
    
    if ([requestString hasPrefix:@"callradio://"]) {
        
        NSString *callString = [[requestString componentsSeparatedByString:@"callradio://"] objectAtIndex:1];
        
        NSLog(@"click : %@", callString);
        
        NSArray *callData = [callString componentsSeparatedByString:@"#n$h$n#"];
        
        NSLog(@"func : %@", [callData objectAtIndex:0]);
        NSLog(@"key : %@", [callData objectAtIndex:1]);
        NSLog(@"title : %@", [callData objectAtIndex:2]);
        
        if ([callData objectAtIndex:1]){
            self.radioModel.playKey = [callData objectAtIndex:1];
            self.radioModel.playInfomation = [callData objectAtIndex:2];
        }
        
        [self do:[callData objectAtIndex:0] key:[callData objectAtIndex:1]];
        
        return NO;
        
    }
    
    return YES;
}

- (void)do:(NSString *)func key:(NSString *)key
{
    NSLog(@"[ do ] %@ : %@", func, key);
    if ([func isEqualToString:@"play"]) {
        NSLog(@"%@ load", key);
        //  play
        //  현재 플레이중인 녀석 멈춤
        if (self.radioModel.status == 3) {
            [self pauseMusic];
        }
        
        //  전달받은 키 플레이
        [self loadMusic:key];
        
    }
}


/**
 *  destroyStreamer
 *
 *  Removes the streamer, the UI update timer and the change notification
 */
- (void)destroyStreamer
{
	if (streamer)
	{
		[ [NSNotificationCenter defaultCenter] removeObserver:self
                                                         name:ASStatusChangedNotification
                                                       object:streamer ];
		[ self.progressUpdateTimer invalidate];
		self.progressUpdateTimer = nil;
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

/**
 *  createStreamer:
 *
 *  Create the streamer
 */
- (void)createStreamer:(NSURL *)url
{
	if (streamer)
	{
		return;
	}
    NSLog(@"url : %@", url);
	streamer = [ [AudioStreamer alloc] initWithURL:url ];
	
	self.progressUpdateTimer = [ NSTimer scheduledTimerWithTimeInterval:0.1
                                                                 target:self
                                                               selector:@selector(updateProgress:)
                                                               userInfo:nil
                                                                repeats:YES ];
	[ [NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(playbackStateChanged:)
                                                  name:ASStatusChangedNotification
                                                object:streamer ];
    
    [streamer start];
}


/**
 *  playbackStateChanged:
 *
 *  Invoked when the AudioStreamer
 *  reports that its playback status has changed.
 */
- (void)playbackStateChanged:(NSNotification *)aNotification
{
//    NSLog(@"aNotification : %@", aNotification);
	if ([streamer isWaiting])
	{
        NSLog(@"isWating");
        [playerView setPlayButtonImageNamed:@"btn_play.png"];
        [playerView setNextButtonImageNamed:@"btn_next.png"];
        self.radioModel.status = 2;
        
        [playerView updateTitle:@"loading..."];
	}
	else if ([streamer isPlaying])
	{
		[playerView setPlayButtonImageNamed:@"btn_pause.png"];
        [playerView setNextButtonImageNamed:@"btn_next.png"];
        self.radioModel.status = 3;
	}
	else if ([streamer isPaused])
	{
		[playerView setPlayButtonImageNamed:@"btn_play.png"];
        self.radioModel.status = 4;
	}
	else if ([streamer isIdle])
	{
        NSLog(@"isIdle");
		[self destroyStreamer];
		[playerView setPlayButtonImageNamed:@"btn_play.png"];
        [playerView setNextButtonImageNamed:@"btn_next.png"];
        self.radioModel.status = 1;
        
        [self nextMusic];
	}
}

/**
 * updateProgress:
 *
 * Invoked when the AudioStreamer
 * reports that its playback progress has changed.
 */
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (self.radioModel.status == 3 && streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		
		if (duration > 0)
		{
            //  곡정보 업데이트
            [playerView updateTitle:self.radioModel.playInfomation];
            
            float percent = progress / duration;
			[playerView updateProgress:percent];
		}
		else
		{
		}
	}
	else
	{
	}
}

- (void)playerUIViewTogglePlay
{
    NSLog(@"click play : %d", self.radioModel.status);
    
    //  현재 재생 가능한 음원이 있는지 확인
    //  현재 재생 가능한 음원이 없다면 웹뷰를 호출하여 음원 키를 가져와야 함
    
    //  현재 재생 가능한 음원이 있다면, 재생중인지 확인
    
    switch (self.radioModel.status) {
        case 1:
            //  prepared
            //  webview call - 재생할 음원 키 요청
            [self playStart];
            
            //  test용
            
            
            break;
        case 2:
            //  loading - 키가 동일하지 않을 경우, 로딩을 멈추고 새로운 키 로드
            break;
        case 3:
            //  play
            [self pauseMusic];
            break;
        case 4:
            //  pause
            [self playMusic];
            break;
        default:
            break;
    }   
}

/**
 *  playerUIViewTogglePlay
 *  현재 재생곡 skip. 다음 재생곡 키 요청
 */
- (void)playerUIViewPassPlay
{
    NSLog(@"click pass");
    //  재생 중지
    [streamer pause];
    [playerView updateProgress:0];
    [self nextMusic];
}

- (void)playerUIViewInfoView
{
    if ([self.radioModel.playList count] > 0) {
        NSLog(@"플레이리스트 보기");
    }else {
        //  최근 플레이리스트가 없는 경우 return;
        NSLog(@"최근 플레이리스트가 없습니다");
    }
}

/**
 *  loadMusic
 *  load music.
 */
-(void)loadMusic:(NSString *)key
{
    NSLog(@"stream 생성 : %@", key);
	[self destroyStreamer];
    
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp3", [self.radioModel getRadioURL], key]];
    
    [self createStreamer:url];
    
}

/**
 *  playMusic
 *  play
 */
-(void)playMusic
{
    [streamer start];
    
}

/**
 *  pauseMusic
 *  pause
 */
-(void)pauseMusic
{
    [streamer pause];
}

- (void)nextMusic
{
    //  webview call - nativeInterface.nextItem()
//    if (onload == YES) {
    
    NSLog(@"%@",[NSString stringWithFormat:@"nativeInterface.nextItem('%@');", self.radioModel.playKey]);
    
        NSString *jsString = [NSString stringWithFormat:@"nativeInterface.nextItem('%@');", self.radioModel.playKey];
        [listView stringByEvaluatingJavaScriptFromString:jsString];
//    }
}

- (void)playStart
{
    NSLog(@"start play");
    //  webview call - radio.playStart
//    if (onload == YES) {
        NSString *jsString = [NSString stringWithFormat:@"nativeInterface.nextItem();"];
        [listView stringByEvaluatingJavaScriptFromString:jsString];
//    }
}

/**
 *  dealloc
 *  Releases instance memory.
 */
- (void)dealloc
{
	[self destroyStreamer];
	if (self.progressUpdateTimer)
	{
		[self.progressUpdateTimer invalidate];
		self.progressUpdateTimer = nil;
	}
    
    [listView release];
    listView = nil;
    
    [playerView release];
    playerView = nil;
    
    [self.radioModel release];
    self.radioModel = nil;
    
	[super dealloc];
}

@end
