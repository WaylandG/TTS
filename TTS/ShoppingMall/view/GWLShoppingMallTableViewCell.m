//
//  GWLShoppingMallTableViewCell.m
//  TTS
//
//  Created by Waylond.G on 2019/3/26.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLShoppingMallTableViewCell.h"

@implementation GWLShoppingMallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.label.textColor = RGBColor(198, 184, 150);
    }else{
         self.label.textColor = [UIColor darkGrayColor];
    }
    // Configure the view for the selected state
}

@end
