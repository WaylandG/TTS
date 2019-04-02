//
//  GWLSubmissionOrderCelltwo.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderCelltwo.h"

@implementation GWLSubmissionOrderCelltwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //控件渲染色(也就是外观字体颜色)
    self.seg.tintColor = RGBColor(96, 194,216);
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1.0;
    self.view1.layer.borderColor = [RGBColor(96, 194,216) CGColor];
    self.view1.backgroundColor = RGBColor(96, 194,216);
    self.view1.layer.cornerRadius = 6.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)segEvent:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"任意");
    }else if (sender.selectedSegmentIndex == 1){
        NSLog(@"周一到周五");
    }else if (sender.selectedSegmentIndex == 2){
        NSLog(@"周末");
    }
}

@end
