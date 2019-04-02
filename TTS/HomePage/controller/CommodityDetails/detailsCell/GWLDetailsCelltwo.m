//
//  GWLDetailsCelltwo.m
//  TTS
//
//  Created by Waylond.G on 2019/3/14.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLDetailsCelltwo.h"

@implementation GWLDetailsCelltwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//地区
- (IBAction)DQbuttonEvent:(UIButton *)sender {
}
//收藏
- (IBAction)SCbuttonEvent:(UIButton *)sender {
}
//减
- (IBAction)jianButtonevent:(UIButton *)sender {
    int number = [_label10.text intValue];
    if ([_label10.text isEqualToString:@"1"]) {
        _label10.text = [NSString stringWithFormat:@"%d",number];
    }else{
        if (number>1) {
            number--;
        }
        _label10.text = [NSString stringWithFormat:@"%d",number];
    }
}
//加
- (IBAction)jiaButtonEvent:(UIButton *)sender {
    int number = [_label10.text intValue];
    number++;
    _label10.text = [NSString stringWithFormat:@"%d",number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
