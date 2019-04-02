//
//  GWLShoppCartViewController.m
//  TTS
//
//  Created by Waylond.G on 2019/3/5.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLShoppCartViewController.h"
#import "HBK_ShoppingCartModel.h"
#import "HBK_ShoppingCartCell.h"
#import "HBK_ShoppingCartHeaderView.h"
#import "HBK_ShopppingCartBottomView.h"

#import "GWLCommodityDetailsController.h"

#define kBottomHeight        kFit(50)

@interface GWLShoppCartViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;//页码
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yueshu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yueshu2;

@property (nonatomic, strong) NSMutableArray<HBK_StoreModel *> *storeArray;
@property (nonatomic, strong) HBK_ShopppingCartBottomView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bottomView_b;

/**
 选中的数组
 */
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation GWLShoppCartViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购物车";
        self.tabBarItem.image= [UIImage imageNamed:@"shopp"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"shopp_S"];
    }
    return self;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view from its nib.
//    http://www.codexiu.cn/ios/blog/40054/
    [self.tableView registerNib:[UINib nibWithNibName:@"HBK_ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;//设置tableView可滑动(默认yes)
//    _tableView.style = UITableViewStyleGrouped ;
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh)];
    _tableView.mj_header = header;
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterRefresh)];
    _tableView.mj_footer = footer;
    _tableView.tableFooterView = [UIView new];
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0, *)) {
        
    } else {
     
//        self.bottomView_b.frame = CGRectMake(self.bottomView_b.frame .origin.x, self.bottomView_b.frame .origin.y-44, self.bottomView_b.frame .size.width, self.bottomView_b.frame .size.height);
        self.yueshu2.constant = 0;
        self.yueshu.constant = 50.0;
        
    }
    self.bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HBK_ShopppingCartBottomView" owner:nil options:nil] objectAtIndex:0];
//    self.bottomView.frame = CGRectMake(0, 0, self.bottomView_b.frame.size.width, self.bottomView.frame.size.height);
    self.bottomView.frame = CGRectMake(0, 0, ScreenWidth, 55);
    //全选
    [self clickAllSelectBottomView:self.bottomView];
    [self.bottomView_b addSubview:self.bottomView];
    [self.view addSubview:self.bottomView_b];
    
    //点击事件的监听
    __weak __typeof__(self) weakSelf = self;

    self.clickItemOperationhomeBlock = ^(id  _Nonnull calss, NSIndexPath * _Nonnull indexPath, NSUInteger id_s , NSUInteger tag_s) {
        if (tag_s ==200) {//点击商品
            if ([calss isKindOfClass:[HBK_ShoppingCartCell class]]) {
                //调转到商品s商品详情
                //跳转到商品详情页面
                GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
                commodityVC.id_s = [NSString stringWithFormat:@"%lu",(unsigned long)id_s];
                commodityVC.title = @"商品详情";
                [weakSelf.navigationController pushViewController:commodityVC animated:YES];
            }
        }else{
          [weakSelf buttonEvent:calss :indexPath];
        }
    };
    
    
     [self loadingDataForPlist];
}

//点击事件的处理
-(void)buttonEvent:(id)calss :(NSIndexPath*)indexPath{
    if ([calss isKindOfClass:[HBK_ShoppingCartCell class]]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        kWeakSelf(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(self);
            [self deleteGoodsWithIndexPath:indexPath];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Action
/// 顶部刷新
- (void)onHeaderRefresh {
    [self requestServerDataReset:YES];
}

/// 底部加载更多
- (void)onFooterRefresh {
    [self requestServerDataReset:NO];
}

#pragma mark - 数据请求
-(void)requestServerDataReset:(BOOL)reset{
    if (reset) {
        self.page = 1;
    }
    NSString *url =  [[NSString alloc]init];
    url = [NSString stringWithFormat:@"%@appucenter/accountLog",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
    [parame setObject:@"3" forKey:@"user_id"];
    //    [parame setObject:@"desc" forKey:@"order"];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
        int flag = [[responseObject objectForKey:@"flag"] intValue];
        if (flag ==1) {
            //            self.row_array = [responseObject objectForKey:@"row"];
        }else{
            [LCProgressHUD showMessage:[responseObject objectForKey:@"msg"]];
        }
        
        //        NSMutableDictionary *data = responseObject;
        //        if (data && data.count) {
        //            [self.dataDicty addObjectsFromArray:data];
        //            self.page ++;
        //        }else{
        int total = 1;
        if (total< 1||total ==1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
//            [self loadingDataForPlist];
            
        }else{
            [self.tableView.mj_footer endRefreshing];
            [LCProgressHUD showInfoMsg:@"失败啦！"];
            //                 [self.tableView.mj_footer resetNoMoreData];//打开下拉刷新
        }
        //        }
        
        //        self.dataDicty = responseObject;
        //        self.rec_parray = [self.dataDicty objectForKey:@"rec_p"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HBK_StoreModel *storeModel = self.storeArray[section];
    return storeModel.goodsArray.count;
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  self.storeArray.count;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return -30;
}

////设置区头视图
//-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary *dic = @{@"namekey":@"账户余额",@"yuenumber":@"0"};
//    
//    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=RGBColor(93, 192, 213);//透明颜色
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
//    lbl.text = [dic objectForKey:@"namekey"];;
//    lbl.textAlignment=NSTextAlignmentCenter;
//    //    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lbl.textColor=RGBColor(178, 238, 240);
//    lbl.font = [UIFont systemFontOfSize:12.0];
//    [view addSubview:lbl];
//    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
//    lb2.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"yuenumber"]];
//    lb2.textAlignment=NSTextAlignmentCenter;
//    lb2.font = [UIFont systemFontOfSize:30.0];
//    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lb2.textColor = [UIColor whiteColor];
//    [view addSubview:lb2];
//    
//    //    cell.newsArray = [self.dataDicty objectForKey:@"rec_p"];
//    //    NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
//    //    NSDictionary *storedic= [dic objectForKey:@"store"];
//    
//    return view;
//}
//设置区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"indexpathone";
    HBK_ShoppingCartCell *cellone = [tableView dequeueReusableCellWithIdentifier:str];
    //        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cellone) {
        cellone = [[HBK_ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    //        cellone.homeVC= self;
    //        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
    HBK_StoreModel *storeModel = self.storeArray[indexPath.section];
    HBK_GoodsModel *goodsModel = storeModel.goodsArray[indexPath.row];
    cellone.goodsModel = goodsModel;
    cellone.indexPath = indexPath;
    cellone.homeVC = self;
    //把事件的处理分离出去
    [self shoppingCartCellClickAction:cellone storeModel:storeModel goodsModel:goodsModel indexPath:indexPath];
    
    return cellone;
    
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    HBK_ShoppingCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HBK_ShoppingCartHeaderView"];
//    headerView.contentView.backgroundColor = [UIColor whiteColor];
//    HBK_StoreModel *storeModel = self.storeArray[section];
//    headerView.storeModel = storeModel;
//    //分区区头点击事件--- 把事件分离出去
//    [self clickSectionHeaderView:headerView andHBK_StoreModel:storeModel];
//    return headerView;
//}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        kWeakSelf(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(self);
            [self deleteGoodsWithIndexPath:indexPath];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UITableViewDataSource
//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];//反选
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //     cell.selected = NO;
    //    GWLOrderDetailsController *VC= [[GWLOrderDetailsController alloc]initWithNibName:@"GWLOrderDetailsController" bundle:nil];
    //    GWLOrderViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    VC.order_no = cell.label.text;
    //    VC.title = @"订单详情";
    //    [self.navigationController pushViewController:VC animated:YES];
}




#pragma mark ------------------------Action 逻辑处理-----------------------------

/**
 判断分区有没有被全选
 @param section 分区坐标
 */
- (void)judgeIsSelectSection:(NSInteger)section {
    HBK_StoreModel *storeModel = self.storeArray[section];
    BOOL isSelectSection = YES;
    //遍历分区商品, 如果有商品的没有被选择, 跳出循环, 说明没有全选
    for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
        if (goodsModel.isSelect == NO) {
            isSelectSection = NO;
            break;
        }
    }
    //全选了以后, 改变一下选中状态
    HBK_ShoppingCartHeaderView *headerView = (HBK_ShoppingCartHeaderView *)[self.tableView headerViewForSection:section];
    headerView.isClick = isSelectSection;
    storeModel.isSelect = isSelectSection;
}

/**
 是否全选
 */
- (void)judgeIsAllSelect {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (count == self.selectArray.count) {
        self.bottomView.isClick = YES;
    } else {
        self.bottomView.isClick = NO;
    }
}


/**
 计算价格
 */
- (void)countPrice {
    double totlePrice = 0.0;
    for (HBK_GoodsModel *goodsModel in self.selectArray) {
        double price = [goodsModel.realPrice doubleValue];
        totlePrice += price * [goodsModel.count integerValue];
    }
    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计 ￥%.2f", totlePrice];
}



#pragma mark  ----------- Action 点击事件 --------------------
/**
 区头点击----选中某个分区/取消选中某个分区
 @param headerView 分区
 @param storeModel 分区模型
 */
- (void)clickSectionHeaderView:(HBK_ShoppingCartHeaderView *)headerView andHBK_StoreModel:(HBK_StoreModel *)storeModel {
    headerView.ClickBlock = ^(BOOL isClick) {
        storeModel.isSelect = isClick;
        
        if (isClick) {//选中
            NSLog(@"选中");
            for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                goodsModel.isSelect = YES;
                if (![self.selectArray containsObject:goodsModel]) {
                    [self.selectArray addObject:goodsModel];
                }
            }
            
        } else {//取消选中
            NSLog(@"取消选中");
            for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                goodsModel.isSelect = NO;
                if ([self.selectArray containsObject:goodsModel]) {
                    [self.selectArray removeObject:goodsModel];
                }
            }
        }
        [self judgeIsAllSelect];
        [self.tableView reloadData];
        [self countPrice];
    };
}


/**
 全选点击---逻辑处理
 @param bottomView 底部的View
 */
- (void)clickAllSelectBottomView:(HBK_ShopppingCartBottomView *)bottomView {
    kWeakSelf(self);
    bottomView.AllClickBlock = ^(BOOL isClick) {
        kStrongSelf(self);
        for (HBK_GoodsModel *goodsModel in self.selectArray) {
            goodsModel.isSelect = NO;
        }
        [self.selectArray removeAllObjects];
        if (isClick) {//选中
            NSLog(@"全选");
            for (HBK_StoreModel *storeModel in self.storeArray) {
                storeModel.isSelect = YES;
                for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                    goodsModel.isSelect = YES;
                    [self.selectArray addObject:goodsModel];
                }
            }
        } else {//取消选中
            NSLog(@"取消全选");
            for (HBK_StoreModel *storeModel in self.storeArray) {
                storeModel.isSelect = NO;
            }
        }
        [self.tableView reloadData];
        [self countPrice];
    };
    
    bottomView.AccountBlock = ^{
        NSLog(@"去结算");
    };
    
    
}

- (void)shoppingCartCellClickAction:(HBK_ShoppingCartCell *)cell
                         storeModel:(HBK_StoreModel *)storeModel
                         goodsModel:(HBK_GoodsModel *)goodsModel
                          indexPath:(NSIndexPath *)indexPath {
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        goodsModel.isSelect = isClick;
        if (isClick) {//选中
            NSLog(@"选中");
            [self.selectArray addObject:goodsModel];
        } else {//取消选中
            NSLog(@"取消选中");
            [self.selectArray removeObject:goodsModel];
        }
        [self judgeIsSelectSection:indexPath.section];
        [self judgeIsAllSelect];
        [self countPrice];
    };
    //加
    cell.AddBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        goodsModel.count = countLabel.text;
        [storeModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
        
    };
    //减
    cell.CutBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        goodsModel.count = countLabel.text;
        [storeModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
    };
}

/**
 删除某个商品
 @param indexPath 坐标
 */
- (void)deleteGoodsWithIndexPath:(NSIndexPath *)indexPath {
    HBK_StoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.section];
    HBK_GoodsModel *goodsModel = [storeModel.goodsArray objectAtIndex:indexPath.row];
    [storeModel.goodsArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    if (storeModel.goodsArray.count == 0) {
        [self.storeArray removeObjectAtIndex:indexPath.section];
    }
    
    if ([self.selectArray containsObject:goodsModel]) {
        [self.selectArray removeObject:goodsModel];
        [self countPrice];
    }
    
    NSInteger count = 0;
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    if (self.selectArray.count == count) {
        _bottomView.clickBtn.selected = YES;
    } else {
        _bottomView.clickBtn.selected = NO;
    }
    
    if (count == 0) {
        //此处加载购物车为空的视图
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark  -------------------- 此处模仿网络请求, 加载plist文件内容
- (void)loadingDataForPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist"];
    NSDictionary *dataDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@", dataDic);
    NSArray *dataArray = dataDic[@"data"];
    [self.storeArray removeAllObjects];
    if (dataArray.count > 0) {
        for (NSDictionary *dic in dataArray) {
            HBK_StoreModel *model = [[HBK_StoreModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.storeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } else {
        //加载数据为空时的展示
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
