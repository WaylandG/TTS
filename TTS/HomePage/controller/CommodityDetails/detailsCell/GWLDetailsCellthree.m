//
//  GWLDetailsCellthree.m
//  TTS
//
//  Created by Waylond.G on 2019/3/14.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLDetailsCellthree.h"

@implementation GWLDetailsCellthree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //控件渲染色(也就是外观字体颜色)
    self.seg.tintColor = RGBColor(170, 170, 170);
    //按下是否会自动释放：
//    self.seg.momentary = YES;
}
- (IBAction)segControl:(UISegmentedControl *)sender {
    self.homeVC.clickItemOperationhomeBlock(self, sender.selectedSegmentIndex);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
