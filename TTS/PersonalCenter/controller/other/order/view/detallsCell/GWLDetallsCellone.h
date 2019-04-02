//
//  GWLDetallsCellone.h
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLOrderDetailsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLDetallsCellone : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_b;
@property (weak, nonatomic) IBOutlet UILabel *label_n;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (nonatomic ,strong) GWLOrderDetailsController *homeVc;

@end

NS_ASSUME_NONNULL_END
