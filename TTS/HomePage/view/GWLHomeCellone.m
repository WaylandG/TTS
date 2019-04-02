//
//  GWLHomeCellone.m
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomeCellone.h"
#import "SDCycleScrollView.h"
@interface GWLHomeCellone()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewEvent;
//轮播
@property(nonatomic,strong) SDCycleScrollView *bannerView;
@property(nonatomic,strong)NSMutableArray *titlesarray;
@property(nonatomic,assign) BOOL isStart;
@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UIButton *button03;
@property (weak, nonatomic) IBOutlet UIButton *button04;
@property (weak, nonatomic) IBOutlet UIButton *button05;

@end

@implementation GWLHomeCellone
-(NSArray*)titlesarray{
    if (!_titlesarray) {
        _titlesarray = [NSMutableArray array];
    }
    return _titlesarray;
}
-(void)setSlideArray:(NSArray *)slideArray{
    _slideArray = slideArray;
    NSMutableArray *array = [NSMutableArray array];
    if (self.slideArray.count==0) {
        
    }else{
        
        for (int i=0; i<self.slideArray.count; i++) {
            NSDictionary *dic = self.slideArray[i];
            NSString *str = [[NSString alloc]initWithFormat:@"%@%@",[dic objectForKey:@"url"],[dic objectForKey:@"img"]];
            [array addObject:str];
        }
    }
    NSArray *imagesURLStrings = [array copy];
    self.bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200 )];
    self.bannerView.imageURLStringsGroup = imagesURLStrings;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.backgroundColor = RGBColor(244, 242, 252);
    self.bannerView.delegate = self;
    self.bannerView.autoScroll = YES;
    self.bannerView.infiniteLoop = YES;
    self.bannerView.isState = YES;
    //self.bannerView.titlesGroup = titles;
    self.bannerView.currentPageDotColor = RGBColor(244, 94, 150); // 自定义分页控件小圆标颜色RGBColor(244, 242, 252);
    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self setbuttong:self.button01];
    [self setbuttong:self.button02];
    [self setbuttong:self.button03];
    [self setbuttong:self.button04];
    [self setbuttong:self.button05];
    
    [self.viewOne addSubview:self.bannerView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置圆角
    self.viewEvent.layer.masksToBounds = YES;
    self.viewEvent.layer.borderWidth = 0.0;
    self.viewEvent.layer.cornerRadius = 5.0;
    self.viewEvent.backgroundColor = RGBColor(253, 253, 253);
    self.contentView.backgroundColor =  RGBColor(249, 249, 249);
    self.viewEvent.layer.borderColor = [RGBColor(245, 245, 245) CGColor ];
    
    
   


}
-(void)setbuttong:(UIButton *)button{
    //设置圆角
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [RGBColor(246, 246,246) CGColor];
    button.layer.cornerRadius = 6.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//[self bringSubviewToFront:self.viewEvent];
    // Configure the view for the selected state
}

//会员专属
- (IBAction)buttonMembershipEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 101, @"");
}

//在线客服
- (IBAction)buttonOnlineEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 102, @"");
}

//每日活动
- (IBAction)buttonDailyEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 103, @"");
}

//我的收藏
- (IBAction)buttonMyCollectionEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 104, @"");
}

//消息通知
- (IBAction)buttonMessageEvent:(UIButton *)sender {
    _homeVC.clickItemOperationhomeBlock(self, 105, @"");
}





@end
