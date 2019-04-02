//
//  GWLCashwithdrawalCell.h
//  TTS
//
//  Created by Waylond.G on 2019/3/19.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLCashwithdrawalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segC;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textfield4;

@end

NS_ASSUME_NONNULL_END
