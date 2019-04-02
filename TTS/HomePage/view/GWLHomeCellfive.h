//
//  GWLHomeCellfive.h
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLHomePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLHomeCellfive : UITableViewCell
@property (nonatomic,strong)GWLHomePageViewController *homeVC;
@property (nonatomic,strong)NSArray *newsArray; 
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIView *viewd;
@property (nonatomic ,strong)NSString *rec_first_t;
@property (nonatomic ,strong)NSString *rec_sec_t;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@end

NS_ASSUME_NONNULL_END
