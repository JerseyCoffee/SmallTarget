//
//  JSDPhotoManage.m
//  JSDYolo
//
//  Created by Jersey on 2018/9/25.
//  Copyright © 2018年 JSDChain. All rights reserved.
//

#import "JSDPhotoManage.h"
//#import "UIViewController+JSDTool.h"
#import <Photos/Photos.h>

NSString* const kJSDPhotoImageFiles = @"PhotoImage/coffee_";
NSString* const kJSDKitImageFiles = @"PhotoImage/kit_";

@interface JSDPhotoManage () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, assign) JSDImagePickerSourceType sourceType;
@property (nonatomic, copy) void (^finishPicking)(UIImage *image);

@end

@implementation JSDPhotoManage

+ (instancetype)sharePhotoManage {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - Method

+ (void)presentWithViewController:(UIViewController *)viewController sourceType:(JSDImagePickerSourceType)sourceType finishPicking:(void (^)(UIImage *))finishPicking
{
    [JSDPhotoManage sharePhotoManage].sourceType = sourceType;
    [JSDPhotoManage sharePhotoManage].finishPicking = finishPicking;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
    }];
    [[JSDPhotoManage sharePhotoManage] presentWithViewController:viewController];
}

#pragma mark - Private Method

- (void)presentWithViewController:(UIViewController *)viewController
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//    //修复警告 Snapshotting a view that has not been rendered results in an empty snapshot. Ensure your view has been rendered at least once before snapshotting or snapshot after screen updates.
//    UIViewController* currentVC = [UIViewController JSD_findTopViewController];
//    currentVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    switch (self.sourceType) {
        case JSDImagePickerSourceTypeCamera:
        {
            if (self.isCameraAvailable && [self doesCameraSupportTakingPhotos]) {
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"本设备不支持拍照" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alertView show];
                return;
            }
        }
            break;
        case JSDImagePickerSourceTypePhotoLibrary: {
            
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
            
            case JSDImagePickerSourceTypePhotosAlbum:
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    if (@available(iOS 11, *)) {
        controller.delegate = self;
        controller.allowsEditing = YES;
        // 修改导航栏字体颜色.
        [controller.navigationBar setTintColor:[UIColor jsd_mainGrayColor]];
        [viewController presentViewController:controller animated:YES completion:nil];
    } else {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            controller.delegate = self;
            controller.allowsEditing = YES;
            // 修改导航栏字体颜色.
            [controller.navigationBar setTintColor:[UIColor jsd_mainGrayColor]];
            [viewController presentViewController:controller animated:YES completion:nil];
        } else {
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请点击前往设置开启应用相册读取权限, 否则无法正常选取相片" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [JSDAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }
}

- (void)clean
{
    self.sourceType = JSDImagePickerSourceTypePhotoLibrary;
    self.finishPicking = nil;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{

        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            self.finishPicking ? self.finishPicking(image) : NULL;
        } else {
//            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//            self.finishPicking ? self.finishPicking(image) : NULL;
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请点击前往设置开启相册读取权限, 否则无法正常选取相片" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [JSDAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }];
    
    //    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
    //        [picker dismissViewControllerAnimated:YES completion:^{
    //            [info objectForKey:UIImagePickerControllerEditedImage];
    //        }];
    //    } else {
    //        [picker dismissViewControllerAnimated:NO completion:^() {
    //            [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //        }];
    //    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isRearCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)isFrontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)doesCameraSupportTakingPhotos
{
//    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
    return YES;
}

- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickVideosFromPhotoLibrary
{
//    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    return YES;
}

- (BOOL)canUserPickPhotosFromPhotoLibrary
{
//    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    return YES;
}

- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

#pragma mark -- Image

+ (void)savaImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kJSDPhotoImageFiles];
    
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kJSDPhotoImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"保存结果%d---%@", result, error);
        }
        
    } else {
        NSLog(@"图片转换 PNG 失败");
    }
   
}

+ (void)savaKitImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kJSDKitImageFiles];
    
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kJSDKitImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"保存结果%d---%@", result, error);
        }
        
    } else {
        NSLog(@"图片转换 PNG 失败");
    }
    
}

@end

