//
//  PlayerUIView.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 19..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "PlayerUIView.h"

@implementation PlayerUIView

@synthesize delegate;
@synthesize utils;

static int BUTTON_AREA_WIDTH = 128;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        id appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.utils = [appDelegate utils];
        [self.utils retain];
        
        playButton = [utils CreateButton:@"play" type:UIButtonTypeCustom view:self frame:CGRectMake(10, 10, 55, 55) target:self action:@selector(togglePlay)];
        
        [self addSubview:playButton];
        [self setPlayButtonImageNamed:nil];
        
        nextButton = [utils CreateButton:@"next" type:UIButtonTypeCustom view:self frame:CGRectMake(64, 10, 55, 55) target:self action:@selector(nextPlay)];
        
        [self addSubview:nextButton];
        [self setNextButtonImageNamed:nil];
        
        infoLabel = [utils CreateButton:@"재생중인 라디오가 없습니다" type:UIButtonTypeCustom view:self frame:CGRectMake(BUTTON_AREA_WIDTH, 12, self.frame.size.width - BUTTON_AREA_WIDTH - 14, 30) target:self action:@selector(playInfomation)];
        
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.titleLabel.font = [UIFont systemFontOfSize:12.0];
        infoLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        infoLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [infoLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:infoLabel];
        
        progress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 4)];
        progress.backgroundColor = [utils GetUIColorFromWebColor:@"00CC33" Alpha:1.0];
        
        [self addSubview:progress];
    }
    return self;
}

- (void)togglePlay
{
    [delegate playerUIViewTogglePlay];
    
//    RadioViewController *controller = self.window.rootViewController;
//    [controller togglePlay];
}

- (void)nextPlay
{
    [delegate playerUIViewPassPlay];
}

- (void)playInfomation
{
    //  재생 리스트 보기
    [delegate playerUIViewInfoView];
}

- (void)setPlayButtonImageNamed:(NSString *)imageName
{
    if (!imageName)
	{
		imageName = @"btn_play.png";
	}
//	[currentPlayImageName autorelease];
//	currentPlayImageName = [imageName retain];
	
	UIImage *image = [UIImage imageNamed:imageName];
	
	[playButton setImage:image forState:0];
    
}

- (void)setNextButtonImageNamed:(NSString *)imageName
{
    if (!imageName)
	{
		imageName = @"btn_next.png";
	}
    
    UIImage *image = [UIImage imageNamed:imageName];
	[nextButton setImage:image forState:0];
}

- (void)updateProgress:(CGFloat)position
{
    float updateSize = self.frame.size.width * position;
    [progress setFrame:CGRectMake(0, 0, updateSize, 4)];
}

- (void)updateTitle:(NSString *)title
{
    infoLabel.titleLabel.text = title;
}

- (void)dealloc
{
    [self.utils release];
    self.utils = nil;
    
    [playButton release];
    playButton = nil;
    
    [nextButton release];
    nextButton = nil;
    
    [progress release];
    progress = nil;
    
    [infoLabel release];
    infoLabel = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
