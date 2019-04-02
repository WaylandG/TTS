//
//  GWLpersonalCenterCellone.m
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLpersonalCenterCellone.h"

@implementation GWLpersonalCenterCellone

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//提现按钮点击时间
- (IBAction)TiXianButtonEvent:(UIButton *)sender {
    self.homeVC.clickItemOperationhomeBlock(self, 200);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
