//
//  PNTwitterCoverView.m
//  Expecta
//
//  Created by Giuseppe Nucifora on 11/09/2017.
//

#import "PNTwitterCoverView.h"
#import "UIImage+Blur.h"

@interface PNTwitterCoverView()

@property (nonatomic, strong) NSMutableArray *blurImages;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic) CGFloat height;
@end


@implementation PNTwitterCoverView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andContentTopView:nil];
}

- (id)initWithFrame:(CGRect)frame andContentTopView:(UIView*)view
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        _blurImages = [[NSMutableArray alloc] initWithCapacity:20];
        _topView = view;
        _height = frame.size.height;
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    [_blurImages removeAllObjects];
    [self prepareForBlurImages];
    
}

- (void)prepareForBlurImages
{
    CGFloat factor = 0.1;
    [_blurImages addObject:self.image];
    for (NSUInteger i = 0; i < 20; i++) {
        [_blurImages addObject:[self.image boxblurImageWithBlur:factor]];
        factor+=0.04;
    }
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_topView removeFromSuperview];
    [super removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.scrollView.contentOffset.y < 0) {
        
        CGFloat offset = -self.scrollView.contentOffset.y;
        _topView.frame = CGRectMake(0, -offset, 320, _topView.bounds.size.height);
        
        self.frame = CGRectMake(-offset,-offset + _topView.bounds.size.height, 320+ offset * 2, _height + offset);
        NSInteger index = offset / 10;
        if (index < 0) {
            index = 0;
        }
        else if(index >= _blurImages.count) {
            index = _blurImages.count - 1;
        }
        UIImage *image = _blurImages[index];
        if (self.image != image) {
            [super setImage:image];
        }
        
    }
    else {
        _topView.frame = CGRectMake(0, 0, 320, _topView.bounds.size.height);
        
        self.frame = CGRectMake(0,_topView.bounds.size.height, 320, _height);
        UIImage *image = _blurImages[0];
        
        if (self.image != image) {
            [super setImage:image];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}

@end
