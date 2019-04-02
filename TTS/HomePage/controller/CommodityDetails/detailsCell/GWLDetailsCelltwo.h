//
//  GWLDetailsCelltwo.h
//  TTS
//
//  Created by Waylond.G on 2019/3/14.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLCommodityDetailsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLDetailsCelltwo : UITableViewCell
@property (nonatomic,strong)GWLCommodityDetailsController *homeVC;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;

@end

NS_ASSUME_NONNULL_END
