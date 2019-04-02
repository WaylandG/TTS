//
//  GWLDetallsCelltwo.h
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLOrderDetailsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLDetallsCelltwo : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_b;
@property (weak, nonatomic) IBOutlet UIButton *button_n;
@property (nonatomic ,strong) GWLOrderDetailsController *homeVc;
@property (nonatomic ,strong) NSString *ordar_id;

@end

NS_ASSUME_NONNULL_END
