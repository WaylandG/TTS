//
//  GWLShoppMallViewController.m
//  TTS
//商城
//  Created by Waylond.G on 2019/3/5.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLShoppMallViewController.h"
#import "WKWaterViewLayout.h"
#import "WKShops.h"
#import "WKCollectionViewCell.h"
#import "GWLCommodityDetailsController.h"

#import "GWLShoppingMallTableViewCell.h"
#import "GWLCollectionReusableView.h"

static NSString *CustomizeCelliIdentify = @"CustomizeCelliIdentify";

static const CGFloat kLineSpacing = 2.f;   //列间距 |
static const CGFloat kItemSpacing = 2.f;   //item之间的间距  --
static const CGFloat kCellMargins = 2.f;   //左右缩进
static const NSInteger kRowNumber = 2;     //列数
//static const CGFloat kCellHeight  = 80.f;  //Cell高度

@interface GWLShoppMallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabelviewYuesu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabelviewXyuesu;

@property (nonatomic,strong)NSMutableArray *shops;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign) float w;
@property (nonatomic, assign) int page;//页码
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *siteArray;
//请求种类id
@property (nonatomic ,strong)NSString *cat;
@property (nonatomic ,strong)NSString *selstring;
//轮播数组
@property (nonatomic, strong) NSMutableArray *slideArray;


@end

@implementation GWLShoppMallViewController

static NSString *const shopId = @"shop";

- (NSMutableArray *)shops {
    
    if (!_shops) {
        _shops = [NSMutableArray array];
        
    }
    return _shops;
}

-(NSMutableArray *)slideArray{
    if (!_slideArray) {
        _slideArray = [NSMutableArray array];
    }
    return _slideArray;
}

-(NSMutableArray *)siteArray{
    if (!_siteArray) {
        _siteArray = [NSMutableArray array];
    }
    return _siteArray;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商城";
        self.tabBarItem.image= [UIImage imageNamed:@"city"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"city_S"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(217, 217, 217);;
    // Do any additional setup after loading the view from its nib.
    self.cat = @"1";//r默认唯一
    [self tableViewQuest];
    
    //初始化collectionview
    [self setUpCollectionView];
    
    
    
}

//tableView数据请求
-(void)tableViewQuest{
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLShoppingMallTableViewCell" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;//设置tableView可滑动(默认yes)
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGBColor(255, 255, 255);
    if (@available(iOS 11.0, *)) {
        self.tabelviewYuesu.constant = 0;
        self.tabelviewXyuesu.constant = 0;
    } else {
        self.tabelviewYuesu.constant = 64;
        self.tabelviewXyuesu.constant = 44;
    }
    [self.view addSubview:_tableView];
    
    NSString *url =  [[NSString alloc]init];
    url = [NSString stringWithFormat:@"%@appiface/site",DomainName];
    
    [PPNetworkHelper GET:url parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        int flag = [[responseObject objectForKey:@"flag"] intValue];
        if (flag == 1) {
            self.siteArray = [responseObject objectForKey:@"row"];
             self.selstring = @"kong";
            [self.tableView reloadData];
            //设置刷新控件
            NSDictionary *dic  = self.siteArray[0];
            self.cat = [dic objectForKey:@"id"];
            [self setUpRefresh];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

/**
 * 设置刷新控件
 */

- (void)setUpRefresh {
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
}

/**
 *  下拉加载新数据
 */

- (void)loadNewShops {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestServerDataReset:YES];
        
    });
    
}

/**
 *  上拉加载更多数据
 */
- (void)loadMoreShops {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        NSArray *shops = [WKShops mj_objectArrayWithFilename:@"1.plist"];
        
//        [self.shops addObjectsFromArray:shops];
        [self requestServerDataReset:NO];
        
        [self.collectionView reloadData];
        
        //结束刷新
        [self.collectionView.mj_footer endRefreshing];
        
    });
    
}

#pragma mark - 数据请求
-(void)requestServerDataReset:(BOOL)reset{
//    [self.collectionView.mj_header endRefreshing];
//    if ([self.collectionView.mj_header isRefreshing]) {
//        [self.collectionView.mj_header endRefreshing];
//    }else{
//        [LCProgressHUD showMessage:@"正在刷新"];
//    }
    self.tableView.userInteractionEnabled = NO;
    if (reset) {
        self.page = 1;
        [self.collectionView.mj_footer resetNoMoreData];//打开下拉刷新
    }
    //Applogin/goods
    NSString *url =  [[NSString alloc]init];
    url = [NSString stringWithFormat:@"%@appiface/prolist",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
        [parame setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    [parame setObject:self.cat forKey:@"cat"];
//        [parame setObject:@"13" forKey:@"pagesize"];
//        [parame setObject:@"desc" forKey:@"order"];
    [PPNetworkHelper cancelAllRequest];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"%@",[responseObject objectForKey:@"msg"]);
        NSArray *shops = [responseObject objectForKey:@"row"];
        NSArray *slide = [responseObject objectForKey:@"slide"];
//        if (reset) {
//            //下拉刷新前清空所有数据加载新的
            [self.shops removeAllObjects];
            [self.slideArray removeAllObjects];
        
        [self.slideArray addObjectsFromArray:slide];
//        }
//        if (shops && shops.count) {
            [self.shops addObjectsFromArray:shops];
//            int total = [[responseObject objectForKey:@"total"] intValue];
//            if (total ==self.shops.count) {
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
//            }else{
//                self.page ++;
//            }
//
//        }else{
//            int total = [[responseObject objectForKey:@"total"] intValue];
//            if (total< self.shops.count||total ==self.shops.count) {
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
//            }else{
//                [LCProgressHUD showInfoMsg:@"失败啦！"];
//                [self.collectionView.mj_footer resetNoMoreData];//打开下拉刷新
//            }
//        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
         [self.collectionView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
        self.tableView.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.userInteractionEnabled = YES;
    }];
    
}

/**
 * 初始化collectionview
 */

- (void)setUpCollectionView {
    //布局item
    CGFloat collectionViewW = self.collectionView.frame.size.width-104;
    
    self.w = collectionViewW/2-6;
    
//    WKWaterViewLayout *waterLayout = [[WKWaterViewLayout alloc]init];
     UICollectionViewFlowLayout* waterLayout = [[UICollectionViewFlowLayout alloc]init];
//    waterLayout.delegate = self;
    waterLayout.minimumLineSpacing      = kLineSpacing;
    waterLayout.minimumInteritemSpacing = kItemSpacing;
    waterLayout.scrollDirection         = UICollectionViewScrollDirectionVertical;
    float y = 0;
    float x = 0;
    if (@available(iOS 11.0, *)) {
        y = 0;
        x = 0;

    } else {
        y = 64;
        x = 20;

    }
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(104, y, [UIScreen mainScreen].bounds.size.width-104, [UIScreen mainScreen].bounds.size.height-2*y+x) collectionViewLayout:waterLayout];
    self.collectionView = collectionView;

    collectionView.backgroundColor = RGBColor(217, 217, 217);
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WKCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:shopId];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册一个ReusableView，类型是UICollectionElementKindSectionHeader的(头部)
    [collectionView registerClass:[GWLCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReusableView"];
    [self.view addSubview:collectionView];
    
   
    
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}

//每个单元格的大小size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKShops *shops = self.shops[indexPath.row];
    NSMutableDictionary *dic = [shops mj_keyValues];
    
    float labelH =[self getHeightLineWithString:[dic objectForKey:@"name"] withWidth:([UIScreen mainScreen].bounds.size.width-104-kItemSpacing*(kRowNumber-1))/kRowNumber withFont:[UIFont systemFontOfSize:15.0]];
//    if ((labelH+44)>80) {
//        //        return itemWidth * 159 / itemWidth+labelH+54;
//        labelH = 140 +labelH+54;
//    }else{
//        //        return itemWidth * 159 / itemWidth+80;
//        labelH =  140+80;
//        labelH = 140 +labelH+54;
//    }
    
    labelH =  140+85;
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-100-kItemSpacing*(kRowNumber-1))/kRowNumber-kCellMargins*2, labelH);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopId forIndexPath:indexPath ];
    
    WKShops *shops = self.shops[indexPath.row];
    
    cell.shops = shops;
    
    NSMutableDictionary *dic = [shops mj_keyValues];

    float labelH =[self getHeightLineWithString:[dic objectForKey:@"name"] withWidth:self.w
                                       withFont:[UIFont systemFontOfSize:18.0]];
    if ((labelH+54)>80) {
        cell.yushu.constant =labelH+54;

    }else{
        cell.yushu.constant =80;
//        cell.yushu.constant =labelH+54;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
    //    [LCProgressHUD showMessage:[NSString stringWithFormat:@"%ld点击了",indexPath.row+1]];
    //跳转到商品详情页面
    GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
    commodityVC.title = @"商品详情";
    NSDictionary *dic = self.shops[indexPath.row];
    commodityVC.id_s = [dic objectForKey:@"id"];
    [self.navigationController pushViewController:commodityVC animated:YES];
    
    
}

//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCellMargins, kCellMargins, kCellMargins, kCellMargins);//分别为上、左、下、右
}

#pragma mark - 根据字符串计算label高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}




#pragma mark headView大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-104, 100);
}

#pragma mark headView和footView都在这里判断
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     GWLCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReusableView" forIndexPath:indexPath];
    headerView.slideArray = self.slideArray;
    return headerView;
   
}


#pragma mark - UITableViewDelegate

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.siteArray.count;
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"indexpathone";
    GWLShoppingMallTableViewCell *cellone = [tableView dequeueReusableCellWithIdentifier:str];
    //        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cellone) {
        cellone = [[GWLShoppingMallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDictionary *dic =self.siteArray[indexPath.row];
    cellone.label.text = [dic objectForKey:@"name"];
    if ([self.selstring isEqualToString:@"kong"]) {
        if (indexPath.row==0) {
            [cellone setSelected:YES animated:NO];
            
            self.selstring = @"OK";
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else{
           
        }
        
    }
    
    
    return cellone;
}

#pragma mark - UITableViewDataSource
//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    GWLShoppingMallTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [self.tableView reloadData];
//    cell.label.textColor=  RGBColor(198, 184, 150);
    NSDictionary *dic =self.siteArray[indexPath.row];
    
    self.cat = [dic objectForKey:@"id"];
    if ([self.collectionView.mj_header isRefreshing]) {
         self.tableView.userInteractionEnabled = NO;
    }else{
         [self setUpRefresh];
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
