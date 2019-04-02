//
//  GWLCollectionReusableView.m
//  TTS
//
//  Created by Waylond.G on 2019/3/26.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLCollectionReusableView.h"
#import "SDCycleScrollView.h"

@interface GWLCollectionReusableView()<SDCycleScrollViewDelegate>
//轮播
@property(nonatomic,strong) SDCycleScrollView *bannerView;
@property(nonatomic,strong)NSMutableArray *titlesarray;

@end

@implementation GWLCollectionReusableView

-(NSArray*)titlesarray{
    if (!_titlesarray) {
        _titlesarray = [NSMutableArray array];
    }
    return _titlesarray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        
    }
    return self;
}

-(void)setSlideArray:(NSArray *)slideArray{
    _slideArray = slideArray;
    NSMutableArray *array = [NSMutableArray array];
    if (self.slideArray.count==0) {
        
    }else{
         NSString *str = [[NSString alloc]init];
        for (int i=0; i<self.slideArray.count; i++) {
            NSDictionary *dic = self.slideArray[i];
            if ([dic isKindOfClass:[NSNull class]] || [dic isEqual:[NSNull null]]) {
               
                
//                return;
                if (i==0) {
                    str = @"https://img-my.csdn.net/uploads/201407/26/1406383291_8239.jpg";
                }else{
                    str = @"https://img-my.csdn.net/uploads/201407/26/1406383291_6518.jpg";
                }
            }else{
                str = [[NSString alloc]initWithFormat:@"%@",[dic objectForKey:@"url"]];
            }
            
            [array addObject:str];
        }
    }
    NSArray *imagesURLStrings = [array copy];
    self.bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(2, 0, self.frame.size.width-2, self.frame.size.height)];
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
   
    
    [self addSubview:self.bannerView];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
