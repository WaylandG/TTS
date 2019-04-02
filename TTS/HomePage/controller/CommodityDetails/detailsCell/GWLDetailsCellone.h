//
//  GWLDetailsCellone.h
//  TTS
//
//  Created by Waylond.G on 2019/3/14.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLCommodityDetailsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLDetailsCellone : UITableViewCell
@property (nonatomic,strong)GWLCommodityDetailsController *homeVC;

@property (nonatomic,strong)NSArray *slideArray;
@end

NS_ASSUME_NONNULL_END
