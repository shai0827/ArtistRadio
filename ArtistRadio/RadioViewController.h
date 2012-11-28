//
//  RadioViewController.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 17..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerUIViewProtocol.h"
#import "RadioModel.h"
#import "AudioStreamer.h"
#import "PlayerUIView.h"

@interface RadioViewController : UIViewController <PlayerUIViewProtocol, UIWebViewDelegate, UIAlertViewDelegate>
{
    RadioModel *radioModel;
    
    //  streamer
	AudioStreamer *streamer;
    PlayerUIView *playerView;
    
    BOOL onload;
    UIWebView *listView;
    NSURLRequest *webRequest;
    
	NSTimer *progressUpdateTimer;
}

@property (nonatomic, retain) NSTimer *progressUpdateTimer;
@property (nonatomic, retain) RadioModel *radioModel;
@property (nonatomic, assign) BOOL onload;

- (void)updateProgress:(NSTimer *)aNotification;
- (void)playerUIViewTogglePlay;
- (void)playerUIViewPassPlay;

@end
