//
//  PLResizeControl.h
//  PhotoCropEditor
//
//  Created by Noam Etzion-Rosenberg on 2013/05/19.
//  Copyright (c) 2013 Noam Etzion-Rosenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PLResizeControl : UIView

@property (weak, nonatomic) id delegate;
@property (nonatomic, readonly) CGPoint translation;

@end

@protocol PLResizeConrolViewDelegate <NSObject>

- (void)resizeConrolViewDidBeginResizing:(PLResizeControl *)resizeConrolView;
- (void)resizeConrolViewDidResize:(PLResizeControl *)resizeConrolView;
- (void)resizeConrolViewDidEndResizing:(PLResizeControl *)resizeConrolView;

@end
