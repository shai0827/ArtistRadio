//
//  ListUIWebView.h
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 21..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListUIWebView : UIWebView
{
    BOOL onload;
    NSURLRequest *webRequest;
}

@property (nonatomic, assign) BOOL onload;
@property (nonatomic, retain) NSURLRequest *webRequest;

- (void)loadWebPage: (NSString *)url;
- (void)setScrollViewBackgroundColor:(UIColor *)color;


@end
