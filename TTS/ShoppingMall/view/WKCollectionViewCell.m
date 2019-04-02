//
//  WKCollectionViewCell.m
//  瀑布流
//
//  Created by 阿拉斯加的狗 on 2016/10/15.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "WKShops.h"
@interface WKCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *qinLabel;
@property (weak, nonatomic) IBOutlet UIButton *gouwubutton;
@property (weak, nonatomic) IBOutlet UIButton *goumaibutton;


@end

@implementation WKCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RGBColor(239, 239, 244);
    //设置圆角
    self.gouwubutton.layer.masksToBounds = YES;
    self.gouwubutton.layer.borderWidth = 0.0;
    self.gouwubutton.layer.cornerRadius = 3.0;
    self.gouwubutton.backgroundColor = RGBColor(197, 186, 156);
    //设置圆角
    self.goumaibutton.layer.masksToBounds = YES;
    self.goumaibutton.layer.borderWidth = 0.0;
    self.goumaibutton.layer.cornerRadius = 3.0;
    self.goumaibutton.backgroundColor = RGBColor(197, 186, 156);
}

- (void)setShops:(WKShops *)shops {

    _shops = shops;
    NSMutableDictionary *dic = [_shops mj_keyValues];
    
    NSURL *url = [NSURL URLWithString:[dic objectForKey:@"imgsrc"]];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
//     self.shops.h = self.imageView.image.size.height;
//    self.shops.w = self.imageView.image.size.width;
    self.priceLable.text = [dic objectForKey:@"name"];
    self.qinLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"sell_price"]];
    

}

- (IBAction)gouwuButtonEvent:(UIButton *)sender {
}

- (IBAction)goumaiButtonEvent:(UIButton *)sender {
}


@end
