//
//  GWLDetallsCellone.m
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLDetallsCellone.h"

@implementation GWLDetallsCellone

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.button02.layer.masksToBounds = YES;
    self.button02.layer.borderWidth =  0.5;
    self.button02.layer.borderColor = [RGBColor(119,119,119) CGColor];
    self.button02.layer.cornerRadius = 3.0;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderWidth =  0.5;
    self.button.layer.borderColor = [RGBColor(119,119,119) CGColor];
    self.button.layer.cornerRadius = 3.0;
}
- (IBAction)buttonEvent:(UIButton *)sender {
    self.homeVc.clickItemOperationhomeBlock(self, 100, @"");
}
- (IBAction)buttonEvent02:(id)sender {
     self.homeVc.clickItemOperationhomeBlock(self, 101, @"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
