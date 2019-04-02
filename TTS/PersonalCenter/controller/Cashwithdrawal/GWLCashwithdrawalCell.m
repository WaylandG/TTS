//
//  GWLCashwithdrawalCell.m
//  TTS
//
//  Created by Waylond.G on 2019/3/19.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLCashwithdrawalCell.h"

@implementation GWLCashwithdrawalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //控件渲染色(也就是外观字体颜色)
    self.segC.tintColor = RGBColor(93, 192, 213);
    self.view1.backgroundColor = RGBColor(93, 192, 213); 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
