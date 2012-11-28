//
//  PlayerUIViewProtocol.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 20..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerUIViewProtocol <NSObject>

- (void)playerUIViewTogglePlay;
- (void)playerUIViewPassPlay;
- (void)playerUIViewInfoView;

@end
