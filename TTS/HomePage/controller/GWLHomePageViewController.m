//
//  GWLHomePageViewController.m
//  TTS
//
//  Created by Waylond.G on 2019/3/5.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomePageViewController.h"
#import "GWLHomeCellone.h"
#import "GWLHomeCelltwo.h"
#import "GWLHomeCellthree.h"
#import "GWLHomeCellfour.h"
#import "GWLHomeCellfive.h"

#import "GWLCommodityDetailsController.h"
#import "GWLhomeExclusivemembershipViewController.h"//会员专属
#import "GWLcustomerServiceViewController.h"//在线客服
#import "GWLhonmeDailyActivitiesViewController.h"//每日活动
#import "GWLhomeMyCollectionViewController.h"//我的收藏
#import "GWLhomeMessageNotificationViewController.h"//消息通知



@interface GWLHomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//https://blog.csdn.net/qq_42202551/article/details/80304783
@property (nonatomic,strong) GWLHomeCellfour *fourVC;

@property (nonatomic, assign) int page;//页码
@property (nonatomic, strong) NSMutableDictionary *dataDicty;

//精品推荐
@property (nonatomic,strong) NSMutableArray *rec_parray;

@end

@implementation GWLHomePageViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
        self.tabBarItem.image= [UIImage imageNamed:@"homes"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"homes_S"];
    }
    return self;
}

-(NSMutableDictionary *)dataDicty{
    if (!_dataDicty) {
        _dataDicty = [NSMutableDictionary dictionary];
    }
    return _dataDicty;
}

-(NSMutableArray*)rec_parray{
    if (!_rec_parray) {
        _rec_parray = [NSMutableArray array];
    }
    return _rec_parray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCellone" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCelltwo" bundle:nil] forCellReuseIdentifier:@"indexpathtwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCellthree" bundle:nil] forCellReuseIdentifier:@"indexpaththree"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCellfour" bundle:nil] forCellReuseIdentifier:@"indexpathfour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCellfive" bundle:nil] forCellReuseIdentifier:@"indexpathfive"];
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
    
    //点击事件的监听
    __weak __typeof__(self) weakSelf = self;
    self.clickItemOperationhomeBlock = ^(id  _Nonnull calss, NSInteger currentIndex, NSString * _Nonnull id_s) {
        [weakSelf buttonEvent:calss :currentIndex ids:id_s];
    };
    
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

//点击事件的处理
-(void)buttonEvent:(id)calss :(NSInteger)currentIndex ids:(NSString*)is_s{
    if ([calss isKindOfClass:[GWLHomeCellfour class]]||[calss isKindOfClass:[GWLHomeCellthree class]]||[calss isKindOfClass:[GWLHomeCellfive class]]) {
        NSLog(@"点击了类%ld",currentIndex);
        //跳转到商品详情页面
        GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
        commodityVC.id_s = is_s;
        commodityVC.title = @"商品详情";
        [self.navigationController pushViewController:commodityVC animated:YES];
    }else if ([calss isKindOfClass:[GWLHomeCellone class]]){
//        currentIndex 从101到105分别是按钮点击的、事件
        [self personalcenterCelltwobuttonEvent:currentIndex];
        
    }else{
        NSLog(@"揍你");
    }
}

//其他点击事件的处理
-(void)personalcenterCelltwobuttonEvent:(NSInteger)index{
    //currentIndex50到62分别是点击事件区分
    switch (index) {
        case 101:
            //我的订单
        {
            GWLhomeExclusivemembershipViewController *cashVC = [[GWLhomeExclusivemembershipViewController alloc]initWithNibName:@"GWLhomeExclusivemembershipViewController" bundle:nil];
            cashVC.title = @"会员专属";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 102:
            //余额明细
        {
            GWLcustomerServiceViewController *cashVC = [[GWLcustomerServiceViewController alloc]initWithNibName:@"GWLcustomerServiceViewController" bundle:nil];
            cashVC.title = @"客服在线";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 103:
            //现在充值
        {
            GWLhonmeDailyActivitiesViewController *cashVC = [[GWLhonmeDailyActivitiesViewController alloc]initWithNibName:@"GWLhonmeDailyActivitiesViewController" bundle:nil];
            cashVC.title = @"每日活动";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 104:
            //个人资料
        {
            GWLhomeMyCollectionViewController *cashVC = [[GWLhomeMyCollectionViewController alloc]initWithNibName:@"GWLhomeMyCollectionViewController" bundle:nil];
            cashVC.title = @"我的收藏";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 105:
            //地址管理
        {
            GWLhomeMessageNotificationViewController *cashVC = [[GWLhomeMessageNotificationViewController alloc]initWithNibName:@"GWLhomeMessageNotificationViewController" bundle:nil];
            cashVC.title = @"消息通知";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        
        default:
            break;
    }
}


#pragma mark - 数据请求
-(void)requestServerDataReset:(BOOL)reset{
    if (reset) {
        self.page = 1;
    }
    NSString *url =  [[NSString alloc]init];
    url = [NSString stringWithFormat:@"%@appiface/index",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
//    [parame setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
//    [parame setObject:@"13" forKey:@"pagesize"];
//    [parame setObject:@"desc" forKey:@"order"];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
//        NSMutableDictionary *data = responseObject;
//        if (data && data.count) {
//            [self.dataDicty addObjectsFromArray:data];
//            self.page ++;
//        }else{
            int total = 1;
            if (total< 1||total ==1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];//停止上拉刷新
                
            }else{
                [self.tableView.mj_footer endRefreshing];
                [LCProgressHUD showInfoMsg:@"失败啦！"];
                //                 [self.tableView.mj_footer resetNoMoreData];//打开下拉刷新
            }
//        }
        
        self.dataDicty = responseObject;
        self.rec_parray = [self.dataDicty objectForKey:@"rec_p"];
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
//    if (section ==4) {
//        return 8;
//    }else {
        return 1;
//    }
    
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4+self.rec_parray.count;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 285;
    }else if (indexPath.section == 1){
        return 50;
    }else if (indexPath.section == 2){
        return 100;
    }else if (indexPath.section == 3){
        return 100;
    }else{
         return 260;
    }
   
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0||section == 1||section == 2||section == 3) {
        return 0;
    }else {
        
        return 0;
    }
}
//设置区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//设置区头视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.rec_parray[section-4];
    
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];//透明颜色
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    lbl.text = [dic objectForKey:@"rec_first_t"];
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
    [view addSubview:lbl];
     UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    lb2.text = [dic objectForKey:@"rec_sec_t"];
    lb2.textAlignment=NSTextAlignmentCenter;
    lb2.font = [UIFont systemFontOfSize:12.0];
//    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
    lb2.textColor = RGBColor(217, 217, 217);
    [view addSubview:lb2];
    
//    cell.newsArray = [self.dataDicty objectForKey:@"rec_p"];
//    NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
//    NSDictionary *storedic= [dic objectForKey:@"store"];
    
    return view;
}
//设置区尾视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];//透明颜色
    return view;
}
//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
      static NSString *str=@"indexpathone";
        GWLHomeCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLHomeCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellone.homeVC= self;
        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
        
        return cellone;
    }else if (indexPath.section ==1){
        static NSString *str=@"indexpathtwo";
        GWLHomeCelltwo *celltwo = [tableView dequeueReusableCellWithIdentifier:str];
        celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!celltwo) {
            celltwo = [[GWLHomeCelltwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        celltwo.homeVC = self;
        celltwo.newsArray = [self.dataDicty objectForKey:@"news"];
        return celltwo;
    }else if (indexPath.section ==2){
        static NSString *str=@"indexpaththree";
        GWLHomeCellthree *cellthree = [tableView dequeueReusableCellWithIdentifier:str];
        cellthree.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellthree) {
            cellthree = [[GWLHomeCellthree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellthree.homeVC = self;
        cellthree.newsArray = [self.dataDicty objectForKey:@"home_rec1"];
        
       
        NSString *rtr = [NSString stringWithFormat:@"%@",[[self.dataDicty objectForKey:@"home_rec1"][0] objectForKey:@"url"]];
        [cellthree.viewimage1 sd_setImageWithURL:[NSURL URLWithString:rtr] placeholderImage:[UIImage imageNamed:@""]];
        NSString *rtr2 = [NSString stringWithFormat:@"%@",[[self.dataDicty objectForKey:@"home_rec1"][1] objectForKey:@"url"]];
        [cellthree.viewimage2 sd_setImageWithURL:[NSURL URLWithString:rtr2] placeholderImage:[UIImage imageNamed:@""]];
        return cellthree;
    }else if (indexPath.section ==3){
        static NSString *str=@"indexpathfour";
        GWLHomeCellfour *cellfour = [tableView dequeueReusableCellWithIdentifier:str];
        cellfour.homeVC = self;
        if (!cellfour) {
            cellfour = [[GWLHomeCellfour alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellfour.newsArray = [self.dataDicty objectForKey:@"home_rec2"];
        return cellfour;
    }
    else{
        
        static NSString *str=@"indexpathfive";
        GWLHomeCellfive *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell=[[GWLHomeCellfive alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //将cell设置为可点击(默认yes)
        // cell.userInteractionEnabled = YES;
        
//        cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld区 第%ld行",indexPath.section,indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeVC = self;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.newsArray = [self.dataDicty objectForKey:@"rec_p"];
        NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
        NSDictionary *storedic= [dic objectForKey:@"store"];
        NSString *string = [NSString stringWithFormat:@"%@",[storedic objectForKey:@"url"]];
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dic1 = self.rec_parray[indexPath.section-4];
        cell.label1.text = [dic1 objectForKey:@"rec_first_t"];
        cell.label2.text = [dic1 objectForKey:@"rec_sec_t"];
        
        
        return cell;
    }
    
}

#pragma mark - UITableViewDataSource
//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//反选
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//     cell.selected = NO;
    if (indexPath.section == 0||indexPath.section ==1||indexPath.section ==2||indexPath.section ==3) {
        
    }else{
        //跳转到商品详情页面
        GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
        commodityVC.title = @"商品详情";
        NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
        NSDictionary *storedic= [dic objectForKey:@"store"];
        commodityVC.id_s = [storedic objectForKey:@"id"];
        [self.navigationController pushViewController:commodityVC animated:YES];
    }
  
}

//根据UI设计师给的颜色值返回出UIColor
-(UIColor *) colorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] <6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] !=6)
        return [UIColor clearColor];
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [cString substringWithRange:range];
    range.location =2;
    NSString *gString = [cString substringWithRange:range];
    range.location =4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f) green:((float) g /255.0f) blue:((float) b /255.0f) alpha:1.0f];
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
