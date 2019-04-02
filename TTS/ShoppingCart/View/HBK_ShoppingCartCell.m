//
//  HBK_ShoppingCartCell.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartCell.h"

@implementation HBK_ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cleanButton.layer.masksToBounds = YES;
    self.cleanButton.layer.borderWidth =  1.0;
    self.cleanButton.layer.borderColor =[RGBColor(224, 224, 224) CGColor];
    self.cleanButton.layer.cornerRadius = 6.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cleanButtonEvent:(UIButton *)sender {
    self.homeVC.clickItemOperationhomeBlock(self, self.indexPath, self.indexPath.row+2, sender.tag);
}

//减
- (IBAction)cut:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    int m = [_goodsModel.realPrice intValue]*[self.countLabel.text intValue];
    self.brandLabel.text = [NSString stringWithFormat:@"小结:%d", m];
    if (self.CutBlock) {
        self.CutBlock(self.countLabel);
    }
}

//加
- (IBAction)add:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    int m = [_goodsModel.realPrice intValue]*[self.countLabel.text intValue];
    self.brandLabel.text = [NSString stringWithFormat:@"小结:%d", m];
    if (self.AddBlock) {
        self.AddBlock(self.countLabel);
    }
}

//选中
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    if (self.ClickRowBlock) {
        self.ClickRowBlock(sender.selected);
    }
}

- (void)setGoodsModel:(HBK_GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    self.clickBtn.selected = goodsModel.isSelect;
    if (goodsModel.isSelect) {
        [self.clickBtn setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@", goodsModel.count];
//    self.goodImageView.backgroundColor = kRandomColor;
    self.goodsNameLabel.text = goodsModel.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"单价:%@元", goodsModel.realPrice];
    int m = [goodsModel.realPrice intValue]*[self.countLabel.text intValue];
    self.brandLabel.text = [NSString stringWithFormat:@"小结:%d", m];
}




@end
