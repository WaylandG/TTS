//
//  GWLOrderDetailsController.h
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLOrderDetailsController : UIViewController
@property (nonatomic ,strong) NSString *order_no;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationhomeBlock)(id calss, NSInteger currentIndex, NSString*id_s);
@end

NS_ASSUME_NONNULL_END
