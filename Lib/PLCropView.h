//
//  PLCropView.h
//  PhotoCropEditor
//
//  Created by Noam Etzion-Rosenberg on 2013/05/19.
//  Copyright (c) 2013 Noam Etzion-Rosenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface PLCropView : UIView

@property (nonatomic) UIImage *image;
@property (nonatomic, readonly) UIImage *croppedImage;

@end
