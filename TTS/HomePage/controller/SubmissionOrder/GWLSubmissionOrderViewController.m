//
//  GWLSubmissionOrderViewController.m
//  TTS
//
//  Created by Waylond.G on 2019/3/25.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLSubmissionOrderViewController.h"
#import "GWLSubmissionOrderCellone.h"
#import "GWLSubmissionOrderCelltwo.h"
#import "GWLSubmissionOrderCellthree.h"
#import "GWLSubmissionOrderCellfour.h"
#import "GWLSubmissionOrderCellfive.h"
#import "GWLSubmissionOrderCellsix.h"
#import "GWLSubmissionOrderCellseven.h"

#import "GWLConfirmationOrderViewController.h"

@interface GWLSubmissionOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yushu;
@property (weak, nonatomic) IBOutlet UIView *view_X;

@property(nonatomic ,strong) NSArray *sectionarray;
//实付
@property (weak, nonatomic) IBOutlet UILabel *SFLbael;

//确认
@property (weak, nonatomic) IBOutlet UIButton *OKbutton;

@end

@implementation GWLSubmissionOrderViewController

-(NSArray *)sectionarray{
    if (!_sectionarray) {
        _sectionarray  = @[@"收货人信息"
                           ,@"配送方式"
                           ,@"支付方式"
                           ,@"订单附言"
                           ,@"购买的商品"
                           ,@"结算信息"
                           ,@"发票信息"];
    }
    return _sectionarray;
}


- (void)viewWillAppear:(BOOL)animated{//隐藏tabbar
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{//显示tabbar
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellone" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCelltwo" bundle:nil] forCellReuseIdentifier:@"indexpathtwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellthree" bundle:nil] forCellReuseIdentifier:@"indexpaththree"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellfour" bundle:nil] forCellReuseIdentifier:@"indexpathfour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellfive" bundle:nil] forCellReuseIdentifier:@"indexpathfive"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellsix" bundle:nil] forCellReuseIdentifier:@"indexpathsix"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLSubmissionOrderCellseven" bundle:nil] forCellReuseIdentifier:@"indexpathseven"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;//设置tableView可滑动(默认yes)
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.view_X];
    
    if (@available(iOS 11.0, *)) {
        
    } else {

        self.yushu.constant = 15.0;
        
    }
    
    // 点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
}

//确认订单点击事件
- (IBAction)OKbuttonEvent:(UIButton *)sender {
    GWLConfirmationOrderViewController *VC = [[GWLConfirmationOrderViewController alloc]initWithNibName:@"GWLConfirmationOrderViewController" bundle:nil];
    VC.title= @"订单已提交";
    [self.navigationController pushViewController:VC animated:YES];
}


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
    
    return 7;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 130;
    }else if (indexPath.section == 1){
        return 150;
    }else if (indexPath.section == 2){
        return 120;
    }else if (indexPath.section == 3){
        return 80;
    }else if (indexPath.section == 4){
        return 200;
    }else if (indexPath.section == 5){
        return 270;
    }else{
        return 60;
    }
    
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0||section == 1||section == 2||section == 3) {
        return 40;
    }else {
        
        return 40;
    }
}
//设置区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
//设置区头视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 20)];
    view.backgroundColor=[UIColor clearColor];//透明颜色
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 20)];
    lbl.text = self.sectionarray[section];
    lbl.textAlignment=NSTextAlignmentLeft;
    lbl.textColor=RGBColor(252, 102, 33);
    [view addSubview:lbl];

    
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
        GWLSubmissionOrderCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLSubmissionOrderCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        cellone.homeVC= self;
//        cellone.slideArray = [self.dataDicty objectForKey:@"slide"];
        
        return cellone;
    }else if (indexPath.section ==1){
        static NSString *str=@"indexpathtwo";
        GWLSubmissionOrderCelltwo *celltwo = [tableView dequeueReusableCellWithIdentifier:str];
        celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!celltwo) {
            celltwo = [[GWLSubmissionOrderCelltwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        celltwo.homeVC = self;
//        celltwo.newsArray = [self.dataDicty objectForKey:@"news"];
        return celltwo;
    }else if (indexPath.section ==2){
        static NSString *str=@"indexpaththree";
        GWLSubmissionOrderCellthree *cellthree = [tableView dequeueReusableCellWithIdentifier:str];
        cellthree.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellthree) {
            cellthree = [[GWLSubmissionOrderCellthree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        cellthree.homeVC = self;
//        cellthree.newsArray = [self.dataDicty objectForKey:@"home_rec1"];
        
        
        
        return cellthree;
    }else if (indexPath.section ==3){
        static NSString *str=@"indexpathfour";
        GWLSubmissionOrderCellfour *cellfour = [tableView dequeueReusableCellWithIdentifier:str];
        cellfour.selectionStyle = UITableViewCellSelectionStyleNone;
//        cellfour.homeVC = self;
        if (!cellfour) {
            cellfour = [[GWLSubmissionOrderCellfour alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        cellfour.newsArray = [self.dataDicty objectForKey:@"home_rec2"];
        return cellfour;
    }
    else if (indexPath.section ==4){
        static NSString *str=@"indexpathfive";
        GWLSubmissionOrderCellfive *cellfour = [tableView dequeueReusableCellWithIdentifier:str];
        cellfour.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cellfour.homeVC = self;
        if (!cellfour) {
            cellfour = [[GWLSubmissionOrderCellfive alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //        cellfour.newsArray = [self.dataDicty objectForKey:@"home_rec2"];
        return cellfour;
    }
    else if (indexPath.section ==5){
        static NSString *str=@"indexpathsix";
        GWLSubmissionOrderCellsix *cellfour = [tableView dequeueReusableCellWithIdentifier:str];
        cellfour.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cellfour.homeVC = self;
        if (!cellfour) {
            cellfour = [[GWLSubmissionOrderCellsix alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //        cellfour.newsArray = [self.dataDicty objectForKey:@"home_rec2"];
        return cellfour;
    }
    else{
        
        static NSString *str=@"indexpathseven";
        GWLSubmissionOrderCellseven *cell=[tableView dequeueReusableCellWithIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell=[[GWLSubmissionOrderCellseven alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //将cell设置为可点击(默认yes)
        // cell.userInteractionEnabled = YES;
        
        //        cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld区 第%ld行",indexPath.section,indexPath.row];
       
        
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
//        GWLCommodityDetailsController *commodityVC = [[GWLCommodityDetailsController alloc]initWithNibName:@"GWLCommodityDetailsController" bundle:nil];
//        commodityVC.title = @"商品详情";
//        NSDictionary *dic = [self.dataDicty objectForKey:@"rec_p"][indexPath.section-4];
//        NSDictionary *storedic= [dic objectForKey:@"store"];
//        commodityVC.id_s = [storedic objectForKey:@"id"];
//        [self.navigationController pushViewController:commodityVC animated:YES];
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

#pragma mark --收起键盘
// 滑动空白处隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
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
