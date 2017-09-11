//
//  PNTwitterCoverView.h
//  Expecta
//
//  Created by Giuseppe Nucifora on 11/09/2017.
//

#import <UIKit/UIKit.h>

@interface PNTwitterCoverView : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame andContentTopView:(UIView*)view;

@end
