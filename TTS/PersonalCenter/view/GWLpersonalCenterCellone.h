//
//  GWLpersonalCenterCellone.h
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLPersonalCenterViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLpersonalCenterCellone : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Ylabel01;
@property (weak, nonatomic) IBOutlet UILabel *Ylabel02;
@property (weak, nonatomic) IBOutlet UILabel *Ylabel03;
@property (weak, nonatomic) IBOutlet UILabel *Ylabel04;
@property (weak, nonatomic) IBOutlet UILabel *Zlabel01;
@property (weak, nonatomic) IBOutlet UILabel *Zlabel02;
@property (weak, nonatomic) IBOutlet UILabel *Zlabel03;
@property (weak, nonatomic) IBOutlet UILabel *zlabel04;
@property (nonatomic,strong)GWLPersonalCenterViewController *homeVC;

@end

NS_ASSUME_NONNULL_END
