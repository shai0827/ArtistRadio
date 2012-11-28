//
//  Utils.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 17..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

- (UIButton *)CreateButton:(NSString *)title type:(UIButtonType)type view:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action;
- (UISlider *)CreateSlider:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action;
- (UIColor *)GetUIColorFromWebColor:(NSString *)color Alpha:(CGFloat)alpha;

@end
