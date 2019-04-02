//
//  GWLHomeCellthree.m
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomeCellthree.h"

@implementation GWLHomeCellthree
- (IBAction)button1event:(UIButton *)sender {
    NSDictionary *dic = _newsArray[0];
    
    self.homeVC.clickItemOperationhomeBlock(self, 20,[dic objectForKey:@"id"]);
}
- (IBAction)button2event:(UIButton *)sender {
    NSDictionary *dic = _newsArray[1];
    self.homeVC.clickItemOperationhomeBlock(self, 21,[dic objectForKey:@"id"]);
}

-(void)setNewsArray:(NSArray *)newsArray{
    _newsArray = newsArray;
    if (!_newsArray) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = 0; i<_newsArray.count; i++) {
            
        }
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
