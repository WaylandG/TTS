//
//  GWLOrderDetailsController.m
//  TTS
//订单详情
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLOrderDetailsController.h"
#import "GWLDetallsCellone.h"
#import "GWLDetallsCelltwo.h"
#import "GWLdetallsModel.h"
#import "GWLCommodityDetailsController.h"

@interface GWLOrderDetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;//页码

//第一个Cell的name
@property (nonatomic,strong) NSArray *arraycell1;
//第er个Cell的name
@property (nonatomic,strong) NSArray *arraycell2;

@property (nonatomic, strong) NSMutableDictionary *dataDicty;
@property (nonatomic ,strong) NSMutableArray *array_n;
@property (nonatomic, strong) GWLdetallsModel *demo;

@end

@implementation GWLOrderDetailsController

-(NSMutableDictionary *)dataDicty{
    if (!_dataDicty) {
        _dataDicty = [NSMutableDictionary dictionary];
    }
    return _dataDicty;
}

-(NSArray *)arraycell1{
    if (!_arraycell1) {
        _arraycell1 = @[@"订单编号",@"下单日期"
                        ,@"订单状态",@"订单操作"
                        ,@"订单价格",@"共需支付"
                        ,@"收货人",@"收货地址"
                        ,@"邮编",@"固定电话"
                        ,@"手机号码",@"配送方式"
                        ,@"物流公司",@"快递单号"
                        ,@"运费",@"支付方式"];
    }
    return _arraycell1;
    
}

-(NSArray *)arraycell2{
    if (!_arraycell2) {
        _arraycell2 = @[@"商品",@"商品单价"
                        ,@"商品数量",@"赠送积分"
                        ,@"优惠金额"];
    }
    return _arraycell2;
    
}

-(NSMutableArray *)array_n{
    if (!_array_n) {
        _array_n = [NSMutableArray array];
    }
    return _array_n;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderWidth =  0.5;
    self.tableView.layer.borderColor = [RGBColor(119,119,119) CGColor];
    self.backView.layer.cornerRadius = 6.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetallsCellone" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
     [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetallsCelltwo" bundle:nil] forCellReuseIdentifier:@"indexpathtwo"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;//设置tableView可滑动(默认yes)
    //    _tableView.style = UITableViewStyleGrouped ;
    
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh)];
//    _tableView.mj_header = header;
//    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterRefresh)];
//    _tableView.mj_footer = footer;
//    _tableView.tableFooterView = [UIView new];
//    [_tableView.mj_header beginRefreshing];
    
    [self.backView addSubview:_tableView];
    [self requestServerDataReset:YES];
    //点击事件的监听
    __weak __typeof__(self) weakSelf = self;
    self.clickItemOperationhomeBlock = ^(id  _Nonnull calss, NSInteger currentIndex, NSString * _Nonnull id_s) {
        [weakSelf buttonEvent:calss :currentIndex ids:id_s];
    };
}

//点击事件的处理
-(void)buttonEvent:(id)calss :(NSInteger)currentIndex ids:(NSString*)is_s{
    if ([calss isKindOfClass:[GWLDetallsCellone class]]) {
        NSLog(@"点击了类%ld",currentIndex);
        if (currentIndex ==100) {//取消订单
            [LCProgressHUD showMessage:@"暂未开启"];
        }else if (currentIndex ==101){//立即购买
            [LCProgressHUD showMessage:@"暂未开启"];
        }
    }else if ([calss isKindOfClass:[GWLDetallsCelltwo class]]){
        if (currentIndex ==200) {
            //跳转到商品详情页面
            GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
            commodityVC.id_s = is_s;
            commodityVC.title = @"商品详情";
            [self.navigationController pushViewController:commodityVC animated:YES];
        }
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
    url = [NSString stringWithFormat:@"%@appucenter/orderDetail",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
    [parame setObject:@"1" forKey:@"user_id"];
    [parame setObject:@"128" forKey:@"id"];
    //    [parame setObject:@"desc" forKey:@"order"];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
        int flag = [[responseObject objectForKey:@"flag"] intValue];
        if (flag ==1) {
            self.dataDicty = [responseObject objectForKey:@"row"];
             self.demo = [GWLdetallsModel mj_objectWithKeyValues:[responseObject objectForKey:@"row"]];
            [self.array_n addObject:self.demo.order_no];
            [self.array_n addObject:self.demo.pay_time];
            [self.array_n addObject:self.demo.order_status];
            [self.array_n addObject:self.demo.is_tui];
            [self.array_n addObject:self.demo.order_amount];
            [self.array_n addObject:self.demo.real_amount];
            [self.array_n addObject:self.demo.true_name];
            [self.array_n addObject:self.demo.address];
            [self.array_n addObject:self.demo.email];
            [self.array_n addObject:self.demo.mobile];
            [self.array_n addObject:self.demo.u_mobile];
            [self.array_n addObject:self.demo.delivery];
            [self.array_n addObject:self.demo.accept_time];
            [self.array_n addObject:self.demo.trade_no];
            [self.array_n addObject:self.demo.accept_time];
            [self.array_n addObject:self.demo.trade_no];
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
    if (section==0) {
        return self.arraycell1.count;
    }else{
        return self.arraycell2.count;
    }
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 120;
        }else{
           return 30;
        }
    }
    
    return 30;
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

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        static NSString *str=@"indexpathone";
        GWLDetallsCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLDetallsCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellone.label_b.text = self.arraycell1[indexPath.row];
        if (self.array_n.count !=0) {
            cellone.label_n.text = self.array_n[indexPath.row];
        }
        if (indexPath.row ==3) {
            cellone.label_n.hidden = YES;
            cellone.button.hidden = NO;
            cellone.button02.hidden= NO;
            cellone.homeVc = self;
        }
        
//        cellone.homeVC= self;
//        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
        
        return cellone;
    }else{
        if (indexPath.row==0) {
            static NSString *str=@"indexpathtwo";
            GWLDetallsCelltwo *celltwo = [tableView dequeueReusableCellWithIdentifier:str];
            celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
            if (!celltwo) {
                celltwo = [[GWLDetallsCelltwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            celltwo.label_b.text = self.arraycell2[indexPath.row];
            celltwo.ordar_id = @"2";
            celltwo.homeVc = self;
            
    
            return celltwo;
        }else{
            static NSString *str=@"indexpathone";
            GWLDetallsCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
            cellone.selectionStyle = UITableViewCellSelectionStyleNone;
            if (!cellone) {
                cellone = [[GWLDetallsCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            cellone.label_b.text = self.arraycell2[indexPath.row];
            cellone.label_n.text = [self.dataDicty objectForKey:@"accept_time"];
            return cellone;
        }
        
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
////    GWLOrderViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
////    VC.order_no = cell.label.text;
//    VC.title = @"订单详情";
//    [self.navigationController pushViewController:VC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//反选
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
