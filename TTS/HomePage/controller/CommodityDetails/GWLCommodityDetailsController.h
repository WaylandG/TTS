//
//  GWLCommodityDetailsController.h
//  TTS
//
//  Created by Waylond.G on 2019/3/12.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLCommodityDetailsController : UIViewController

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationhomeBlock)(id calss, NSInteger currentIndex);
//商品id
@property (nonatomic,strong) NSString *id_s;


@end

NS_ASSUME_NONNULL_END
