//
//  GWLSubmissionOrderCellthree.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderCellthree.h"

@implementation GWLSubmissionOrderCellthree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self buttonecddd:self.button1];
    [self buttonecddd:self.button2];
    [self buttonecddd:self.button3];
    [self buttonecddd:self.button4];
    [self buttonecddd:self.button5];
    
    
}
-(void)buttonecddd:(UIButton *)button{
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [RGBColor(225, 225,225) CGColor];
    button.backgroundColor = [UIColor clearColor];
    button.layer.cornerRadius = 6.0;
    
}
- (IBAction)buttonEvent:(UIButton *)sender {//60到64
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    sender.selected=YES;
    for (int i=0; i<5; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:60+i];
        [button setBackgroundImage:[UIImage imageNamed:@"BBJ"] forState:UIControlStateNormal];
    }
    
    sender.backgroundColor = RGBColor(235, 235, 235);
    [sender setBackgroundImage:[UIImage imageNamed:@"BJ"] forState:UIControlStateSelected];
//    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    switch (sender.tag) {
        case 60:
          
            break;
        case 61:
            
            break;
        case 62:
            
            break;
        case 63:
            
            break;
        case 64:
            
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
