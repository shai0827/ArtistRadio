//
//  ListUIWebView.m
//  ArtistRadio
//
//  Created by zena_macbook on 12. 11. 21..
//  Copyright (c) 2012년 zena_macbook. All rights reserved.
//

#import "ListUIWebView.h"

@implementation ListUIWebView

@synthesize webRequest;
@synthesize onload;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadWebPage: (NSString *)url
{
    self.onload = NO;
    
    if (self.webRequest != nil) {
        [self.webRequest release];
        self.webRequest = nil;
    }
    
    self.webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self loadRequest:self.webRequest];
    
}

- (void)setScrollViewBackgroundColor:(UIColor *)color
{
    for (UIView *subview in [self subviews]) {
        subview.backgroundColor = color;
        for (UIView *shadowView in [subview subviews]) {
            if ([shadowView isKindOfClass:[UIImageView class]]) {
                shadowView.hidden = YES;
            }
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webview error : %@", error);
}


- (void)dealloc
{
    [self.webRequest release];
    self.webRequest = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
