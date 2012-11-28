//
//  AppDelegate.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 17..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioViewController.h"
#import "Utils.h"
#import "RadioModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Utils *utils;
    RadioModel *radioModel;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Utils *utils;
@property (nonatomic, retain) RadioModel *radioModel;

@end
