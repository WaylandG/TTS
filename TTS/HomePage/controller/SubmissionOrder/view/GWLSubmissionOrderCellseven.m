//
//  GWLSubmissionOrderCellseven.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderCellseven.h"

@implementation GWLSubmissionOrderCellseven

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.switchButton.tintColor= RGBColor(220, 86, 134);
}
- (IBAction)switchButtonEvent:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"用户要发票");
    }else{
        NSLog(@"用户不要发票");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
