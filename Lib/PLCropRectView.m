//
//  PLCropRectView.m
//  PhotoCropEditor
//
//  Created by Noam Etzion-Rosenberg on 2013/05/21.
//  Copyright (c) 2013 Noam Etzion-Rosenberg. All rights reserved.
//

#import "PLCropRectView.h"
#import "PLResizeControl.h"

@interface PLCropRectView ()

@property (nonatomic) PLResizeControl *topLeftCornerView;
@property (nonatomic) PLResizeControl *topRightCornerView;
@property (nonatomic) PLResizeControl *bottomLeftCornerView;
@property (nonatomic) PLResizeControl *bottomRightCornerView;
@property (nonatomic) PLResizeControl *topEdgeView;
@property (nonatomic) PLResizeControl *leftEdgeView;
@property (nonatomic) PLResizeControl *bottomEdgeView;
@property (nonatomic) PLResizeControl *rightEdgeView;

@property (nonatomic) CGRect initialRect;
@property (nonatomic, getter = isLiveResizing) BOOL liveResizing;

@end

@implementation PLCropRectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeRedraw;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, -2.0f, -2.0f)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.image = [[UIImage imageNamed:@"PLPhotoCropEditorBorder"] resizableImageWithCapInsets:UIEdgeInsetsMake(23.0f, 23.0f, 23.0f, 23.0f)];
        [self addSubview:imageView];
        
        self.topLeftCornerView = [[PLResizeControl alloc] init];
        self.topLeftCornerView.delegate = self;
        [self addSubview:self.topLeftCornerView];
        
        self.topRightCornerView = [[PLResizeControl alloc] init];
        self.topRightCornerView.delegate = self;
        [self addSubview:self.topRightCornerView];
        
        self.bottomLeftCornerView = [[PLResizeControl alloc] init];
        self.bottomLeftCornerView.delegate = self;
        [self addSubview:self.bottomLeftCornerView];
        
        self.bottomRightCornerView = [[PLResizeControl alloc] init];
        self.bottomRightCornerView.delegate = self;
        [self addSubview:self.bottomRightCornerView];
        
        self.topEdgeView = [[PLResizeControl alloc] init];
        self.topEdgeView.delegate = self;
        [self addSubview:self.topEdgeView];
        
        self.leftEdgeView = [[PLResizeControl alloc] init];
        self.leftEdgeView.delegate = self;
        [self addSubview:self.leftEdgeView];
        
        self.bottomEdgeView = [[PLResizeControl alloc] init];
        self.bottomEdgeView.delegate = self;
        [self addSubview:self.bottomEdgeView];
        
        self.rightEdgeView = [[PLResizeControl alloc] init];
        self.rightEdgeView.delegate = self;
        [self addSubview:self.rightEdgeView];
    }
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSArray *subviews = self.subviews;
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[PLResizeControl class]]) {
            if (CGRectContainsPoint(subview.frame, point)) {
                return subview;
            }
        }
    }
    
    return nil;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    
//    CGFloat width = CGRectGetWidth(self.bounds);
//    CGFloat height = CGRectGetHeight(self.bounds);
//    
//    UIColor *lineColor = [UIColor whiteColor];
//    [lineColor set];
//    
//    for (NSInteger i = 1; i < 3; i++) {
//        UIRectFill(CGRectMake(0.0f, roundf(height / 3 * i), roundf(width), 1.0f));
//        UIRectFill(CGRectMake(roundf(width / 3 * i), 0.0f, 1.0f, roundf(height)));
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topLeftCornerView.frame = (CGRect){CGRectGetWidth(self.topLeftCornerView.bounds) / -2, CGRectGetHeight(self.topLeftCornerView.bounds) / -2, self.topLeftCornerView.bounds.size};
    self.topRightCornerView.frame = (CGRect){CGRectGetWidth(self.bounds) - CGRectGetWidth(self.topRightCornerView.bounds) / 2, CGRectGetHeight(self.topRightCornerView.bounds) / -2, self.topLeftCornerView.bounds.size};
    self.bottomLeftCornerView.frame = (CGRect){CGRectGetWidth(self.bottomLeftCornerView.bounds) / -2, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.bottomLeftCornerView.bounds) / 2, self.bottomLeftCornerView.bounds.size};
    self.bottomRightCornerView.frame = (CGRect){CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bottomRightCornerView.bounds) / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.bottomRightCornerView.bounds) / 2, self.bottomRightCornerView.bounds.size};
    self.topEdgeView.frame = (CGRect){CGRectGetMaxX(self.topLeftCornerView.frame), CGRectGetHeight(self.topEdgeView.frame) / -2, CGRectGetMinX(self.topRightCornerView.frame) - CGRectGetMaxX(self.topLeftCornerView.frame), CGRectGetHeight(self.topEdgeView.bounds)};
    self.leftEdgeView.frame = (CGRect){CGRectGetWidth(self.leftEdgeView.frame) / -2, CGRectGetMaxY(self.topLeftCornerView.frame), CGRectGetWidth(self.leftEdgeView.bounds), CGRectGetMinY(self.bottomLeftCornerView.frame) - CGRectGetMaxY(self.topLeftCornerView.frame)};
    self.bottomEdgeView.frame = (CGRect){CGRectGetMaxX(self.bottomLeftCornerView.frame), CGRectGetMinY(self.bottomLeftCornerView.frame), CGRectGetMinX(self.bottomRightCornerView.frame) - CGRectGetMaxX(self.bottomLeftCornerView.frame), CGRectGetHeight(self.bottomEdgeView.bounds)};
    self.rightEdgeView.frame = (CGRect){CGRectGetWidth(self.bounds) - CGRectGetWidth(self.rightEdgeView.bounds) / 2, CGRectGetMaxY(self.topRightCornerView.frame), CGRectGetWidth(self.rightEdgeView.bounds), CGRectGetMinY(self.bottomRightCornerView.frame) - CGRectGetMaxY(self.topRightCornerView.frame)};
}

- (void)resizeConrolViewDidBeginResizing:(PLResizeControl *)resizeConrolView
{
    self.liveResizing = YES;
    self.initialRect = self.frame;
    
    if ([self.delegate respondsToSelector:@selector(cropRectViewDidBeginEditing:)]) {
        [self.delegate cropRectViewDidBeginEditing:self];
    }
}

- (void)resizeConrolViewDidResize:(PLResizeControl *)resizeConrolView
{
    self.frame = [self cropRectMakeWithResizeControlView:resizeConrolView];
        
    if ([self.delegate respondsToSelector:@selector(cropRectViewEditingChanged:)]) {
        [self.delegate cropRectViewEditingChanged:self];
    }
}

- (void)resizeConrolViewDidEndResizing:(PLResizeControl *)resizeConrolView
{
    self.liveResizing = NO;
    
    if ([self.delegate respondsToSelector:@selector(cropRectViewDidEndEditing:)]) {
        [self.delegate cropRectViewDidEndEditing:self];
    }
}

- (CGRect)cropRectMakeWithResizeControlView:(PLResizeControl *)resizeControlView
{
    CGRect rect = self.frame;
    
    if (resizeControlView == self.topEdgeView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect),
                          CGRectGetMinY(self.initialRect) + resizeControlView.translation.y,
                          CGRectGetWidth(self.initialRect),
                          CGRectGetHeight(self.initialRect) - resizeControlView.translation.y);
    } else if (resizeControlView == self.leftEdgeView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetMinY(self.initialRect),
                          CGRectGetWidth(self.initialRect) - resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect));
    } else if (resizeControlView == self.bottomEdgeView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect),
                          CGRectGetMinY(self.initialRect),
                          CGRectGetWidth(self.initialRect),
                          CGRectGetHeight(self.initialRect) + resizeControlView.translation.y);
    } else if (resizeControlView == self.rightEdgeView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect),
                          CGRectGetMinY(self.initialRect),
                          CGRectGetWidth(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect));
    } else if (resizeControlView == self.topLeftCornerView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetMinY(self.initialRect) + resizeControlView.translation.y,
                          CGRectGetWidth(self.initialRect) - resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect) - resizeControlView.translation.y);
    } else if (resizeControlView == self.topRightCornerView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect),
                          CGRectGetMinY(self.initialRect) + resizeControlView.translation.y,
                          CGRectGetWidth(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect) - resizeControlView.translation.y);
    } else if (resizeControlView == self.bottomLeftCornerView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetMinY(self.initialRect),
                          CGRectGetWidth(self.initialRect) - resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect) + resizeControlView.translation.y);
    } else if (resizeControlView == self.bottomRightCornerView) {
        rect = CGRectMake(CGRectGetMinX(self.initialRect),
                          CGRectGetMinY(self.initialRect),
                          CGRectGetWidth(self.initialRect) + resizeControlView.translation.x,
                          CGRectGetHeight(self.initialRect) + resizeControlView.translation.y);
    }
    
    CGFloat maxWidth = CGRectGetWidth(self.leftEdgeView.bounds) + CGRectGetWidth(self.rightEdgeView.bounds);
    if (CGRectGetWidth(rect) < maxWidth) {
        rect.origin.x = CGRectGetMaxX(self.frame) - maxWidth;
        rect.size.width = maxWidth;
    }
    
    CGFloat maxHeight = CGRectGetHeight(self.topEdgeView.bounds) + CGRectGetHeight(self.bottomEdgeView.bounds);
    if (CGRectGetHeight(rect) < maxHeight) {
        rect.origin.y = CGRectGetMaxY(self.frame) - maxHeight;
        rect.size.height = maxHeight;
    }
    
    return rect;
}

@end
