//
//  GH_ShowDetailJTViewController.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^statusChangeBlock)();
@interface GH_ShowDetailJTViewController : JTBaseViewController
@property (nonatomic, assign)NSInteger orderID;
@property (nonatomic, copy)statusChangeBlock changeBlock;
@end

NS_ASSUME_NONNULL_END

//    self.cell = cell;
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
//        if (status != PHAuthorizationStatusAuthorized) return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
////            picker.extendedLayoutIncludesOpaqueBars = YES;
////            picker.automaticallyAdjustsScrollViewInsets = NO;
////            picker.delegate = self;
//            // 显示选择的索引
//            picker.showsSelectionIndex = YES;
//            picker.defaultAssetCollection = 5;
//            picker.modalPresentationStyle = UIModalPresentationPopover;
//            // 设置相册的类型：相机胶卷 + 自定义相册
//            picker.assetCollectionSubtypes = @[
//                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
//                                               @(PHAssetCollectionSubtypeAlbumRegular)];
//            // 不需要显示空的相册
//            picker.showsEmptyAlbums = NO;
//            [self presentViewController:picker animated:YES completion:nil];
//        });
//    }];
//-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
//{
//    NSInteger max = 9;
//    if (picker.selectedAssets.count >= max) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
//        [picker presentViewController:alert animated:YES completion:nil];
//        // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
//        return NO;
//    }
//    return YES;
//}
//
//-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    // 关闭图片选择界面
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    // 基本配置
//    CGFloat scale = [UIScreen mainScreen].scale;
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.resizeMode   = PHImageRequestOptionsResizeModeFast;
//    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
//    NSMutableArray * temp = [NSMutableArray new];
//    if (temp.count >= 0) {
//        [temp removeAllObjects];
//    }
//    // 遍历选择的所有图片
//    for (NSInteger i = 0; i < assets.count; i++) {
//        PHAsset *asset = assets[i];
//        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
//        // 获取图片
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            [temp addObject:result];
////            UIImageView *imageView = [[UIImageView alloc] init];
////            imageView.image = result;
////            //            imageView.frame = CGRectMake((i % 3) * 110, (i / 3) * 110, 100, 100);
////            [self.imageview addSubview:imageView];
////            imageView.sd_layout.autoHeightRatio(1);
////            [temp addObject:imageView];
//        }];
//
//    }
//
//    NSArray * array = self.picArray[self.indexpath.row];
//    NSMutableArray * photoImage = [NSMutableArray new];
//    for (UIImage * image in array) {
//        [photoImage addObject:image];
//    }
//    for (UIImage * image in temp) {
//        [photoImage addObject:image];
//    }
//    array = photoImage;
//    [self.picArray replaceObjectAtIndex:self.indexpath.row withObject:array];
////    [self.picArray addObject:array];
//    [self.table reloadData];
//}
