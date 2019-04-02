//
//  GWLBalanceViewController.m
//  TTS
//余额明细
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLBalanceViewController.h"
#import "GWLbalanceCell.h"

@interface GWLBalanceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) int page;//页码

@end

@implementation GWLBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tableView.layer.masksToBounds = YES;
//    self.tableView.layer.borderWidth =  1.0;
//    self.tableView.layer.borderColor = [RGBColor(246, 246,246) CGColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLbalanceCell" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
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
    
    [self.view addSubview:_tableView];//
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
    return 1;
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 130;
    }else {
        
        return 0;
    }
}

//设置区头视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = @{@"namekey":@"账户余额",@"yuenumber":@"0"};
    
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=RGBColor(93, 192, 213);//透明颜色
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    lbl.text = [dic objectForKey:@"namekey"];;
    lbl.textAlignment=NSTextAlignmentCenter;
//    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
    lbl.textColor=RGBColor(178, 238, 240);
    lbl.font = [UIFont systemFontOfSize:12.0];
    [view addSubview:lbl];
    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
    lb2.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"yuenumber"]];
    lb2.textAlignment=NSTextAlignmentCenter;
    lb2.font = [UIFont systemFontOfSize:30.0];
    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
    lb2.textColor = [UIColor whiteColor];
    [view addSubview:lb2];
    
    //    cell.newsArray = [self.dataDicty objectForKey:@"rec_p"];
    //    NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
    //    NSDictionary *storedic= [dic objectForKey:@"store"];
    
    return view;
}
//设置区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"indexpathone";
    GWLbalanceCell *cellone = [tableView dequeueReusableCellWithIdentifier:str];
    //        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cellone) {
        cellone = [[GWLbalanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    //        cellone.homeVC= self;
    //        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
    
    
    return cellone;
    
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
