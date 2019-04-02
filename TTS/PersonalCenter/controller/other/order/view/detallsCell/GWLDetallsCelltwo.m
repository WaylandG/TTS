//
//  GWLDetallsCelltwo.m
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLDetallsCelltwo.h"

@implementation GWLDetallsCelltwo
//-(void)setOrdar_id:(NSString *)ordar_id{
//    self.ordar_id = ordar_id;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonevent:(UIButton *)sender {
    
        self.homeVc.clickItemOperationhomeBlock(self, 200, self.ordar_id);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
