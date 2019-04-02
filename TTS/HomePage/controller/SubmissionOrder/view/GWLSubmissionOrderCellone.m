//
//  GWLSubmissionOrderCellone.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderCellone.h"

@implementation GWLSubmissionOrderCellone

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置圆角
    self.button1_view1.layer.masksToBounds = YES;
    self.button1_view1.layer.borderWidth = 1.0;
    self.button1_view1.layer.borderColor = [RGBColor(44, 144,166) CGColor];
    self.button1_view1.backgroundColor = RGBColor(44, 144,166);
    self.button1_view1.layer.cornerRadius = 6.0;
    
    self.button2_view1.layer.masksToBounds = YES;
    self.button2_view1.layer.borderWidth = 1.0;
    self.button2_view1.layer.borderColor = [RGBColor(44, 144,166) CGColor];
    self.button2_view1.backgroundColor = RGBColor(44, 144,166);
    self.button2_view1.layer.cornerRadius = 6.0;
    
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1.0;
    self.view1.layer.borderColor = [RGBColor(96, 194,216) CGColor];
    self.view1.backgroundColor = RGBColor(96, 194,216);
    self.view1.layer.cornerRadius = 6.0;
    
    self.view2.layer.masksToBounds = YES;
    self.view2.layer.borderWidth = 1.0;
    self.view2.layer.borderColor = [RGBColor(246, 95,145) CGColor];
    self.view2.backgroundColor = RGBColor(246, 95,145);
    self.view2.layer.cornerRadius = 6.0;
    
    
}

//修改
- (IBAction)button1_view1Event:(UIButton *)sender {
    
}

//删除
- (IBAction)button2_view1Event:(UIButton *)sender {
    
}

//添加新地址
- (IBAction)button3_view2event:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
