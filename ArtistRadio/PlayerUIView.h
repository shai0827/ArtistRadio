//
//  PlayerUIView.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 19..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerUIViewProtocol.h"
#import "Utils.h"

//@protocol PlayerUIDelegate <NSObject>
//
//- (void)playerUIViewTogglePlay;
//
//@end

@interface PlayerUIView : UIView{
    id<PlayerUIViewProtocol> delegate;
    Utils *utils;
    
    UIButton *playButton;
    UIButton *nextButton;
    UIView *progress;
    UIButton *infoLabel;
}

@property (nonatomic, assign) id<PlayerUIViewProtocol> delegate;
@property (nonatomic, retain) Utils *utils;

- (void)setPlayButtonImageNamed:(NSString *)imageName;
- (void)setNextButtonImageNamed:(NSString *)imageName;
- (void)updateProgress:(CGFloat)position;
- (void)updateTitle:(NSString *)title;

@end
