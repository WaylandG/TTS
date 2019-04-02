//
//  GWLHomeCellthree.h
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLHomePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWLHomeCellthree : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *viewimage1;
@property (weak, nonatomic) IBOutlet UIImageView *viewimage2;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic,strong)GWLHomePageViewController *homeVC;
@property (nonatomic,strong)NSArray *newsArray; 

@end

NS_ASSUME_NONNULL_END
