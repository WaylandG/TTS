//
//  GWLPersonalCenterViewController.h
//  TTS
//
//  Created by Waylond.G on 2019/3/5.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLPersonalCenterViewController : UIViewController
/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationhomeBlock)(id calss, NSInteger currentIndex);

@end

NS_ASSUME_NONNULL_END
