//
//  PLCropRectView.h
//  PhotoCropEditor
//
//  Created by Noam Etzion-Rosenberg on 2013/05/21.
//  Copyright (c) 2013 Noam Etzion-Rosenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLCropRectView : UIView

@property (nonatomic) id delegate;

@end

@protocol PLCropRectViewDelegate <NSObject>

- (void)cropRectViewDidBeginEditing:(PLCropRectView *)cropRectView;
- (void)cropRectViewEditingChanged:(PLCropRectView *)cropRectView;
- (void)cropRectViewDidEndEditing:(PLCropRectView *)cropRectView;

@end

