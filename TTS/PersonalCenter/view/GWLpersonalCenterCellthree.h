//
//  GWLpersonalCenterCellthree.h
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLPersonalCenterViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLpersonalCenterCellthree : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property(nonatomic,strong) NSMutableDictionary *userdic;
@property (nonatomic,strong)GWLPersonalCenterViewController *homeVC;

@end

NS_ASSUME_NONNULL_END
