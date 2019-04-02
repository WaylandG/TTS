//
//  LDuserTableViewCell.m
//  BIM_Ios_App
//
//  Created by 龙的LONG on 2017/11/1.
//  Copyright © 2017年 longday. All rights reserved.
//

#import "LDuserTableViewCell.h"

@implementation LDuserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置图片圆角
    self.nameImage.layer.masksToBounds = YES;
    self.nameImage.layer.cornerRadius = 30.0;
    self.nameImage.layer.borderWidth = 1.0;
    self.nameImage.layer.borderColor = [RGBColor(240, 240, 245) CGColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
