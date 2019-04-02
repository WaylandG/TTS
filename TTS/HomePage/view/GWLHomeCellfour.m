//
//  GWLHomeCellfour.m
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomeCellfour.h"
#import "GWLhomeCollectionViewCell.h"

static NSString *cellID = @"cell";
@interface GWLHomeCellfour ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *myCollectionView;
@end

@implementation GWLHomeCellfour
-(void)setNewsArray:(NSArray *)newsArray{
    _newsArray = newsArray;
    if (_newsArray) {
        [self.myCollectionView reloadData];
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect collectionViewFrame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 4;
    // 每一列cell之间的间距
    // flowLayout.minimumInteritemSpacing = 10;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);
        flowLayout.itemSize = CGSizeMake(89, 90);// 该行代码就算不写,item也会有默认尺寸
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = RGBColor(246, 246, 246);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    [collectionView registerNib:[UINib nibWithNibName:@"GWLhomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    _myCollectionView = collectionView;
    
    [self addSubview:collectionView];
    
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
//    self.chaunZhiBlock = ^(NSString *str){
//        NSLog(@"%@",str);
//    };
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.newsArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GWLhomeCollectionViewCell *cell = (GWLhomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSDictionary *dic = self.newsArray[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]];
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;
}

-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
//    [LCProgressHUD showMessage:[NSString stringWithFormat:@"%ld点击了",indexPath.row+1]];
    GWLhomeCollectionViewCell*cell = (GWLhomeCollectionViewCell *)[_myCollectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *dic = _newsArray[indexPath.row];
    _homeVC.clickItemOperationhomeBlock(self, indexPath.row,[dic objectForKey:@"id"]);

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
