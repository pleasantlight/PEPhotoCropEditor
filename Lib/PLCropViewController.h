//
//  PLCropViewController.h
//  PhotoCropEditor
//
//  Created by Noam Etzion-Rosenberg on 2013/05/19.
//  Copyright (c) 2013 Noam Etzion-Rosenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLCropViewController : UIViewController

@property (nonatomic) id delegate;
@property (nonatomic) UIImage *image;

@end

@protocol PLCropViewControllerDelegate <NSObject>

- (void)cropViewController:(PLCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;
- (void)cropViewControllerDidCancel:(PLCropViewController *)controller;

@end
