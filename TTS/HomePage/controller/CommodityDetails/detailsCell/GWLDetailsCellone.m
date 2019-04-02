//
//  GWLDetailsCellone.m
//  TTS
//
//  Created by Waylond.G on 2019/3/14.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLDetailsCellone.h"

#import "SDCycleScrollView.h"
@interface GWLDetailsCellone()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewEvent;
//轮播
@property(nonatomic,strong) SDCycleScrollView *bannerView;
@property(nonatomic,strong)NSMutableArray *titlesarray;
@property(nonatomic,assign) BOOL isStart;
//@property (weak, nonatomic) IBOutlet UIButton *button01;
//@property (weak, nonatomic) IBOutlet UIButton *button02;
//@property (weak, nonatomic) IBOutlet UIButton *button03;
//@property (weak, nonatomic) IBOutlet UIButton *button04;
//@property (weak, nonatomic) IBOutlet UIButton *button05;

@end

@implementation GWLDetailsCellone

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
            NSString *str = [[NSString alloc]initWithFormat:@"%@",[dic objectForKey:@"img"]];
            [array addObject:str];
        }
    }
    NSArray *imagesURLStrings = [array copy];
    self.bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 365 )];
    self.bannerView.imageURLStringsGroup = imagesURLStrings;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.backgroundColor = RGBColor(244, 242, 252);
    self.bannerView.delegate = self;
    self.bannerView.autoScroll = NO;
    self.bannerView.infiniteLoop = NO;
    self.bannerView.isState = YES;
    //self.bannerView.titlesGroup = titles;
    self.bannerView.currentPageDotColor = RGBColor(244, 94, 150); // 自定义分页控件小圆标颜色RGBColor(244, 242, 252);
    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [self addSubview:self.bannerView];
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
