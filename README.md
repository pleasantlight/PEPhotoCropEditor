PLPhotoCropEditor
=================

PLPhotoCropEditor is image cropping library for iOS, similar to the Photos.app UI.

<img src="https://raw.github.com/pleasantlight/PLPhotoCropEditor/master/Screenshots/ss01.png" alt="ScreenShot 1" width="280px" style="width: 280px;" />&nbsp;<a href="https://vimeo.com/66661806"><img src="https://raw.github.com/pleasantlight/PLPhotoCropEditor/master/Screenshots/ss02.png" alt="[Movie 1" width="440px" style="width: 440px;" /></a>

## License
MIT License

## System requirements
- iOS 5.0 or higher
- Both iPhone/iPad supported

## Installation
### CocoaPods
`pod 'PLPhotoCropEditor'`

## Usage

**Use view controller component**
```objective-c
 PLCropViewController *controller = [[PLCropViewController alloc] init];
 controller.delegate = self;
 controller.image = self.imageView.image;
 
 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
 [self presentViewController:navigationController animated:YES completion:NULL];
```

**Or use the crop view directly**
```objective-c
self.cropView = [[PLCropView alloc] initWithFrame:contentView.bounds];
[self.view addSubview:self.cropView];
```

### Get the cropped image

**delegate method**
```objective-c
- (void)cropViewController:(PLCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = croppedImage;
}
```

**retrieve from view directly**
```objective-c
UIImage *croppedImage = self.cropView.croppedImage;
```
