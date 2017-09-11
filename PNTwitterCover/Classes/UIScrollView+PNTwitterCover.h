//
//  UIScrollView+PNTwitterCover.h
//  Expecta
//
//  Created by Giuseppe Nucifora on 11/09/2017.
//

#import <UIKit/UIKit.h>
#import "PNTwitterCoverView.h"

#define DefaultTwitterCoverViewHeight 200

@interface UIScrollView (PNTwitterCover)

@property(nonatomic,weak) PNTwitterCoverView *twitterCoverView;

- (void)addTwitterCoverWithImage:(UIImage*)image;
- (void)addTwitterCoverWithImage:(UIImage*)image withTopView:(UIView*)topView;
- (void)addTwitterCoverWithImage:(UIImage*)image withTopView:(UIView*)topView andHeight:(CGFloat) height;
- (void)removeTwitterCoverView;

@end
