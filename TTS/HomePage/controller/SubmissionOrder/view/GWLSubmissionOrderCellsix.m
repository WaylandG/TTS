//
//  GWLSubmissionOrderCellsix.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderCellsix.h"

@implementation GWLSubmissionOrderCellsix

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.buttonD.layer.masksToBounds = YES;
    self.buttonD.layer.borderWidth = 1.0;
    self.buttonD.layer.borderColor = [RGBColor(225, 225,225) CGColor];
    self.buttonD.backgroundColor = RGBColor(220, 86, 134);
    self.buttonD.layer.cornerRadius = 6.0;
}
- (IBAction)bttonDEvent:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
