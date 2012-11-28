//
//  Utils.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 17..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "Utils.h"

@implementation Utils

- (UIButton *)CreateButton:(NSString *)title type:(UIButtonType)type view:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action
{
    
    NSLog(@"\n# CreateButton : title = %@", title);
    
    UIButton *button = [[UIButton buttonWithType:type] retain];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
    
    return button;
}

- (UISlider *)CreateSlider:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action
{
    UISlider *slider = [[UISlider alloc] init];
    [slider setFrame:frame];
    [slider addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    
	return slider;
}

- (UIColor *)GetUIColorFromWebColor:(NSString *)color Alpha:(CGFloat)alpha
{
    unsigned int rgb;
    
    [[NSScanner scannerWithString:color] scanHexInt:&rgb];
    
//    UIColor *resultColor = [[UIColor colorWithRed:((rgb & 0xff0000) >> 16)/255.0 green:((rgb & 0xff00) >> 8)/255.0 blue:(rgb & 0xff)/255.0  alpha:alpha]];
    
    UIColor *resultColor = [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:alpha];
    
    
    return resultColor;
}

@end
