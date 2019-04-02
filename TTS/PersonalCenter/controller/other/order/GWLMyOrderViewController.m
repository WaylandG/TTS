//
//  GWLMyOrderViewController.m
//  TTS
//我的订单
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLMyOrderViewController.h"
#import "GWLOrderViewCell.h"
#import "GWLOrderDetailsController.h"

@interface GWLMyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, assign) int page;//页码

@property (nonatomic,strong) NSMutableArray *row_array;

@end

@implementation GWLMyOrderViewController

-(NSMutableArray*)row_array{
    if (!_row_array) {
        _row_array = [NSMutableArray array];
    }
    return _row_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderWidth =  1.0;
    self.tableView.layer.borderColor = [RGBColor(246, 246,246) CGColor];
    self.backView.layer.cornerRadius = 6.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLOrderViewCell" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
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
    [self.backView addSubview:_tableView];
    //[self.view addSubview:_tableView];//
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
    url = [NSString stringWithFormat:@"%@appucenter/order",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
        [parame setObject:@"3" forKey:@"user_id"];
    //    [parame setObject:@"desc" forKey:@"order"];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
        int flag = [[responseObject objectForKey:@"flag"] intValue];
        if (flag ==1) {
            self.row_array = [responseObject objectForKey:@"row"];
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
    return self.row_array.count;
    
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 40;
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
    return 0;
}

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *str=@"indexpathone";
        GWLOrderViewCell *cellone = [tableView dequeueReusableCellWithIdentifier:str];
//        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        cellone.homeVC= self;
//        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
    NSDictionary *dic = self.row_array[indexPath.row];
    cellone.label.text = [dic objectForKey:@"order_no"];
        
        return cellone;
    
}

#pragma mark - UITableViewDataSource
//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];//反选
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //     cell.selected = NO;
    GWLOrderDetailsController *VC= [[GWLOrderDetailsController alloc]initWithNibName:@"GWLOrderDetailsController" bundle:nil];
         GWLOrderViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    VC.order_no = cell.label.text;
    VC.title = @"订单详情";
    [self.navigationController pushViewController:VC animated:YES];
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
