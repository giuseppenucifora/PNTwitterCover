//
//  UIScrollView+PNTwitterCover.m
//  Expecta
//
//  Created by Giuseppe Nucifora on 11/09/2017.
//

#import "UIScrollView+PNTwitterCover.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

static char UIScrollViewTwitterCover;

@implementation UIScrollView (PNTwitterCover)

- (void)setTwitterCoverView:(PNTwitterCoverView *)twitterCoverView {
    [self willChangeValueForKey:@"twitterCoverView"];
    objc_setAssociatedObject(self, &UIScrollViewTwitterCover,
                             twitterCoverView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"twitterCoverView"];
}

- (PNTwitterCoverView *)twitterCoverView {
    return objc_getAssociatedObject(self, &UIScrollViewTwitterCover);
}

- (void)addTwitterCoverWithImage:(UIImage*)image
{
    [self addTwitterCoverWithImage:image withTopView:nil];
}
- (void)addTwitterCoverWithImage:(UIImage*)image withTopView:(UIView*)topView {
    [self addTwitterCoverWithImage:image withTopView:topView width:[UIScreen mainScreen].bounds.size.width andHeight:DefaultTwitterCoverViewHeight];
}

- (void)addTwitterCoverWithImage:(UIImage*)image withTopView:(UIView*)topView width:(CGFloat) width andHeight:(CGFloat) height
{
    PNTwitterCoverView *view = [[PNTwitterCoverView alloc] initWithFrame:CGRectMake(0,0, width, height) andContentTopView:topView];
    
    view.backgroundColor = [UIColor clearColor];
    view.image = image;
    view.scrollView = self;
    
    [self addSubview:view];
    if (topView) {
        [self addSubview:topView];
    }
    self.twitterCoverView = view;
}

- (void)removeTwitterCoverView
{
    [self.twitterCoverView removeFromSuperview];
    self.twitterCoverView = nil;
}

@end
