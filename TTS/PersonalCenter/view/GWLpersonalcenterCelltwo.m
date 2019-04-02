//
//  GWLpersonalcenterCelltwo.m
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLpersonalcenterCelltwo.h"
#import "GWLPersonalCenterCollectionViewCell.h"

static NSString *cellID = @"cell";
@interface GWLpersonalcenterCelltwo ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *myCollectionView;
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSArray *labelnameArray;

@end

@implementation GWLpersonalcenterCelltwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageArray = @[@"my order80-1",@"mingxi80-1",@"chongzhi80-1",@"personal data80-1"
                        ,@"address80-1",@"XIUGAIMM80-1"
                        ,@"money80-1",@"VIP80-1"
                        ,@"KEFU80×80-1",@"tuiguang80-1"
                        ,@"fenhong80-1",@"ledou80-1"];
    self.labelnameArray = @[@"我的订单",@"余额明细"
                            ,@"在线充值",@"个人资料"
                            ,@"地址管理",@"修改密码"
                            ,@"资金转账",@"会员福利"
                            ,@"专属客服",@"我要推广"
                            ,@"专属分红",@"乐豆专题"];
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30)/3, 70); //设置item的大小
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical; //设置布局方式
    layOut.sectionInset = UIEdgeInsetsMake(1, 1,1, 1); //设置距离上 左 下 右
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - 64) collectionViewLayout:layOut];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"GWLPersonalCenterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"]; //注册xib文件
        [self addSubview:collectionView];
    
}

//实现代理协议
 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
         return 12;
     }
 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        GWLPersonalCenterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//        cell.img.image = [UIImage imageNamed:@"image1"];
     cell.namelabel.text = self.labelnameArray[indexPath.row];
     cell.imageView.image= [UIImage imageNamed:self.imageArray[indexPath.row]];
     if ((indexPath.row+1)%2) {
         cell.backgroundColor = RGBColor(245, 245, 245);
     }
     else{
         cell.backgroundColor = RGBColor(240, 236, 226);
     }
        return cell;
     
 }
//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 8)/3,70);
}

//定义每个section四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
        return UIEdgeInsetsMake(0, 0,0,0);
}

//两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
        return 4.0f;
}

//同一行两个cell的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
        return 4.0f;
}
-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    //    [LCProgressHUD showMessage:[NSString stringWithFormat:@"%ld点击了",indexPath.row+1]];
    _homeVC.clickItemOperationhomeBlock(self, indexPath.row+50);
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
