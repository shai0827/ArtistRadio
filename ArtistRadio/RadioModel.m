//
//  RadioModel.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 20..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel

@synthesize playKey;
@synthesize playInfomation;
@synthesize playList;

/**
 *  status
 *  1 : prepared
 *  2 : loading
 *  3 : play
 *  4 : pause
 */
@synthesize status;

static NSString *MUSIC_SOURCE_URL = @"http://flashdev.naver.com/FlashUILab/FlashUI1/KimHyeYoung/study/ios/artistRadio/source/";
//static NSString *RADIO_LIST_WEB_URL = @"http://zenadot.dothome.co.kr/radio/";
static NSString *RADIO_LIST_WEB_URL = @"http://flashdev.naver.com/FlashUILab/FlashUI1/KimHyeYoung/study/ios/artistRadio/html2/";
static int PLAYER_HEIGHT = 86;
static int PADDING = 15;
static int SHADOW = 8;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        playList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)getRadioURL
{
    return MUSIC_SOURCE_URL;
}

- (NSString *)getListURL
{
    return RADIO_LIST_WEB_URL;
}

- (CGRect)getListViewRect:(CGSize)viewSize
{
    return CGRectMake(PADDING+SHADOW, PADDING+SHADOW, viewSize.width - (PADDING*2) - ( SHADOW * 2), viewSize.height - PLAYER_HEIGHT - PADDING - SHADOW);
}

- (CGRect)getPlayerViewRect:(CGSize)viewSize
{
    return CGRectMake(PADDING, viewSize.height - PLAYER_HEIGHT, viewSize.width - (PADDING*2), PLAYER_HEIGHT);
}

- (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:48/255.0 green:48/255.0 blue:57/255.0 alpha:1.0];
}

- (void)dealloc
{
    [playKey release];
    playKey = nil;
    
    [playInfomation release];
    playInfomation = nil;
    
    [playList release];
    playList = nil;
    
    [super dealloc];
}

@end
