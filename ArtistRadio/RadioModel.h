//
//  RadioModel.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 20..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioModel : NSObject
{
    int status;
    NSString *currentKey;
    NSMutableArray *playList;
}

@property (nonatomic, assign) int status;
@property (nonatomic, retain) NSString *currentKey;
@property (nonatomic, retain) NSMutableArray *playList;

- (NSString *)getRadioURL;
- (NSString *)getListURL;
- (CGRect)getListViewRect:(CGSize)viewSize;
- (CGRect)getPlayerViewRect:(CGSize)viewSize;

@end
