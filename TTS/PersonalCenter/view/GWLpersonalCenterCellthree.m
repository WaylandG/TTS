//
//  GWLpersonalCenterCellthree.m
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLpersonalCenterCellthree.h"


@implementation GWLpersonalCenterCellthree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userdic = [NSMutableDictionary dictionaryWithContentsOfFile:userPlistZH];
    //设置圆角
    self.backButton.layer.masksToBounds = YES;
    self.backButton.layer.borderWidth = 0.0;
    self.backButton.layer.cornerRadius = 5.0;
    self.backButton.backgroundColor = RGBColor(207, 182, 125);
}
- (IBAction)backbuttonEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 100);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
