//
//  CLSeeBigViewController.m
//  百思不得姐
//
//  Created by 杨博兴 on 16/10/6.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLSeeBigViewController.h"

#import "CLTopic.h"

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

//#import <AssetsLibrary/AssetsLibrary.h> // iOS9开始废弃
#import <Photos/Photos.h> // iOS9开始推荐

@interface CLSeeBigViewController ()<UIScrollViewDelegate>

/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation CLSeeBigViewController

static NSString * CLAssetCollectionTitle = @"百思不得姐xx_cc";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置SVProgressHUD的显示时间和启动动画时间
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setFadeInAnimationDuration:0.5];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // scrollView.backgroundColor = [UIColor redColor];
    // scrollView.frame = self.view.bounds;
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载完成
        if (image) {
            self.saveBtn.enabled = YES;
        }
    }];
    [scrollView addSubview:imageView];
    
    imageView.cl_width = scrollView.cl_width;
    imageView.cl_height = self.topic.height * imageView.cl_width / self.topic.width;
    imageView.cl_x = 0;
    
    if (imageView.cl_height >= scrollView.cl_height) { // 图片高度超过整个屏幕
        imageView.cl_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.cl_height);
    } else { // 居中显示
        imageView.cl_centerY = scrollView.cl_height * 0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.cl_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    /*
    PHAuthorizationStatusNotDetermined,     用户还没有做出选择
    PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
    PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
    PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
    */
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {
        // 因为家长控制，导致应用无法访问相册（与用户没有关系）
        [SVProgressHUD showErrorWithStatus:@"因为系统原因,无法访问系统相册"];
    }else if (status == PHAuthorizationStatusDenied){
        // 用户点击了不允许
        CLLog(@"设置-隐私-照片-百思不得姐xx_cc-允许");
    }else if (status == PHAuthorizationStatusAuthorized){
        // 获得用户授权,在这里保存图片
        [self saveImage];
    }else if (status == PHAuthorizationStatusNotDetermined){
        // 用户还没有选择进行授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
           // 用户点击好或者不允许 都会到这里，如果不允许则什么都不做，如果好，则保存图片
            if (status == PHAuthorizationStatusAuthorized) {
                // 保存图片
                [self saveImage];
            }
        }];
        
    }
    /** 
     image：要保存的图片
     Target + SEL 会调用target的SEL方法,SEL方法室友格式规定的，必须使用一下格式
     //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
     
     content Info 参数 nil
     */
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

/** 抽取过的存储图片代码 */

- (void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        // 这个方法在子线程中执行，所以需要返回到主线程中去修改UI
        if (success == NO) {
            [self showError:@"保存图片失败!"];
            return;
        }
        // 2.获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            // 这个方法在子线程中执行，所以需要返回到主线程中去修改UI
            [self showError:@"创建相簿失败!"];
            return;
        }
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            // 这个方法在子线程中执行，所以需要返回到主线程中去修改UI
            if (success == NO) {
                [self showError:@"保存图片失败!"];;
            } else {
                [self showSuccess:@"保存图片成功!"];;
            }
        }];
    }];
}

/**
 *  获得相簿
 */
- (PHAssetCollection *)createdAssetCollection
{
    // 从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:CLAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    // 没有找到对应的相簿, 得创建新的相簿
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    // 这个方法在主线程张中执行，等相簿创建完毕之后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:CLAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}





/** 方法二 ，未抽取代码 */
//- (void)saveImage
//{
//    // PHAsset : 一个资源, 比如一张图片\一段视频
//    // PHAssetCollection : 一个相簿
//    
//    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
//    __block NSString *assetCollectionLocalIdentifier = nil;
//    
//    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
//    __block NSString *assetLocalIdentifier = nil;
//    
//    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        // 1.保存图片A到"相机胶卷"中
//        // 创建图片的请求
//        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        if (success == NO) {
//            CLLog(@"保存[图片]到[相机胶卷]中失败!失败信息-%@", error);
//            return;
//        }
//        // 获得曾经创建过的相簿
//        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
//        if (createdAssetCollection) { // 曾经创建过相簿
//            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                // 3.添加"相机胶卷"中的图片A到"相簿"D中
//                
//                // 获得图片
//                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
//                
//                // 添加图片到相簿中的请求
//                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
//                
//                // 添加图片到相簿
//                [request addAssets:@[asset]];
//            } completionHandler:^(BOOL success, NSError * _Nullable error) {
//                if (success == NO) {
//                    CLLog(@"添加[图片]到[相簿]失败!失败信息-%@", error);
//                } else {
//                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//                    CLLog(@"成功添加[图片]到[相簿]!");
//                }
//            }];
//        } else { // 没有创建过相簿
//            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                // 2.创建"相簿"D
//                // 创建相簿的请求
//                assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:CLAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
//            } completionHandler:^(BOOL success, NSError * _Nullable error) {
//                if (success == NO) {
//                    CLLog(@"保存相簿失败!失败信息-%@", error);
//                    return;
//                }
//                
//                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                    // 3.添加"相机胶卷"中的图片A到新建的"相簿"D中
//                    
//                    // 获得相簿
//                    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
//                    
//                    // 获得图片
//                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
//                    
//                    // 添加图片到相簿中的请求
//                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
//                    
//                    // 添加图片到相簿
//                    [request addAssets:@[asset]];
//                } completionHandler:^(BOOL success, NSError * _Nullable error) {
//                    if (success == NO) {
//                        CLLog(@"添加[图片]到[相簿]失败!失败信息-%@", error);
//                    } else {
//                        CLLog(@"成功添加[图片]到[相簿]!");
//                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//                    }
//                }];
//            }];
//        }
//    }];
//}

/**
 *  获得曾经创建过的相簿
 */
//- (PHAssetCollection *)createdAssetCollection
//{
//    // 获得所有相簿
////    PHAssetCollectionTypeAlbum      = 1, 项目自己创建的相簿
////    PHAssetCollectionTypeSmartAlbum = 2, 系统中自己创建的一些相簿
////    PHAssetCollectionTypeMoment     = 3, 按照时间来划分的相簿，可能每一个日期为一个相簿
//    
////    PHAssetCollectionSubtypeAlbumRegular 正规的正常的type
//    
//    // 返回装着所有相簿的数组，PHFetchResult跟NSArry基本上是一样的。
//    
//    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        if ([assetCollection.localizedTitle isEqualToString:CLAssetCollectionTitle]) {
//            return assetCollection;
//        }
//    }
//    
//    return nil;
//}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
//{
//    [SVProgressHUD setMinimumDismissTimeInterval:1];
//    [SVProgressHUD setFadeInAnimationDuration:0.5];
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    }else{
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}
#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
