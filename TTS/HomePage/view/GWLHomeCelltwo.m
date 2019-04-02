//
//  GWLHomeCelltwo.m
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomeCelltwo.h"
@interface GWLHomeCelltwo()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) NSTimer *timer; //定时器
@property (nonatomic, assign) int index;
@end

@implementation GWLHomeCelltwo
-(void)setNewsArray:(NSArray *)newsArray{
    _newsArray = newsArray;
    if (!_newsArray) {
        for (int i = 0; i<_newsArray.count; i++) {
            
        }
        self.index =0;
        [self setTimer];
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code@property (nonatomic, strong) NSTimer *timer; //定时器
}
- (IBAction)buttonEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 13, @"");
}
- (IBAction)GDbuttonEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 14, @"");
}


- (void)setTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
}

- (void)changePos {
    //1秒去一次数据
    if (self.index==self.newsArray.count||self.index<self.newsArray.count) {
        NSDictionary *dic = self.newsArray[self.index];
        NSString *strt = [[NSString alloc]initWithFormat:@"%@",[dic objectForKey:@"title"]];
        [self.button setTitle:strt forState:UIControlStateNormal];
        self.index ++;
        if (self.index==self.newsArray.count) {
            self.index =0;
        }
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
