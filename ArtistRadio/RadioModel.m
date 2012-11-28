//
//  RadioModel.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 20..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel

@synthesize currentKey;
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
static NSString *RADIO_LIST_WEB_URL = @"http://zenadot.dothome.co.kr/radio/";
static int PLAYER_HEIGHT = 86;
static int PADDING = 15;

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
    return CGRectMake(PADDING, PADDING, viewSize.width - (PADDING*2), viewSize.height - PLAYER_HEIGHT - PADDING);
}

- (CGRect)getPlayerViewRect:(CGSize)viewSize
{
    return CGRectMake(PADDING, viewSize.height - PLAYER_HEIGHT, viewSize.width - (PADDING*2), PLAYER_HEIGHT);
}

- (void)dealloc
{
    [currentKey release];
    currentKey = nil;
    
    [playList release];
    playList = nil;
    
    [super dealloc];
}

//- (NSString *)getStatus
//{
//    return self.status;
//}
//
//- (void)setStatus:(NSString *)newStatus
//{
//    self.status = newStatus;
//}

@end
