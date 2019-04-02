//
//  GWLPersonalCenterViewController.m
//  TTS
//
//  Created by Waylond.G on 2019/3/5.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLPersonalCenterViewController.h"
#import "GWLLoginViewController.h"
#import "GWLpersonalCenterCellone.h"
#import "GWLpersonalcenterCelltwo.h"
#import "GWLpersonalCenterCellthree.h"
#import "GWLCashwithdrawalViewController.h"//提现
#import "GWLLedouProjectViewController.h"//乐豆专题
#import "GWLExclusiveDividendViewController.h"//专属分红
#import "GWLMYPromotionViewController.h"//我要推广
#import "GWLcustomerServiceViewController.h"//专属客服
#import "GWLVIPWelfareViewController.h"//会员福利
#import "GWLTransferFundsViewController.h"//资金转账
#import "GWLModifyPasswordViewController.h"//密码修改
#import "GWLAddressManagementViewController.h"//地址管理
#import "GWLUserDataViewController.h"//个人资料
#import "GWLrechargeViewController.h"//在线充值
#import "GWLBalanceViewController.h"//余额明细
#import "GWLMyOrderViewController.h"//我的订单

@interface GWLPersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GWLPersonalCenterViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
        self.tabBarItem.image= [UIImage imageNamed:@"user"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"user_S"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableViewEstablish];
    //点击事件的监听
    __weak __typeof__(self) weakSelf = self;
    self.clickItemOperationhomeBlock = ^(id  _Nonnull calss, NSInteger currentIndex) {
        [weakSelf buttonEvent:calss :currentIndex];
    };
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //判断用户登录的信息是否存在
    if ([[NSFileManager defaultManager]fileExistsAtPath:userPlistZH]) {
        //用登录的信息存在跳转到主页
        [self.tableView reloadData];
    }else{
        GWLLoginViewController *loginVC = [[GWLLoginViewController alloc]initWithNibName:@"GWLLoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}


//点击事件的处理
-(void)buttonEvent:(id)calss :(NSInteger)currentIndex{
    if ([calss isKindOfClass:[GWLpersonalCenterCellone class]]||[calss isKindOfClass:[GWLpersonalcenterCelltwo class]]||[calss isKindOfClass:[GWLpersonalCenterCellthree class]]) {
        NSLog(@"点击了类%ld",currentIndex);
        //跳转到商品详情页面
        if ([calss isKindOfClass:[GWLpersonalCenterCellthree class]]) {
            [self LogoutEvent];//退出登录
        }else if ([calss isKindOfClass:[GWLpersonalCenterCellone class]]){
            [self CashwithdrawalEvent];//提现
        }else if ([calss isKindOfClass:[GWLpersonalcenterCelltwo class]]){
            //currentIndex50到62分别是点击事件区分
            [self personalcenterCelltwobuttonEvent:currentIndex];
        }
        
        
    }else{
        NSLog(@"揍你");
    }
}

//tabelview的创建
-(void)tableViewEstablish{
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLpersonalCenterCellone" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLpersonalcenterCelltwo" bundle:nil] forCellReuseIdentifier:@"indexpathtwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLpersonalCenterCellthree" bundle:nil] forCellReuseIdentifier:@"indexpaththree"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;//设置tableView可滑动(默认yes)
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

//退出登录
-(void)LogoutEvent{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你是否要退出登录或者切换账号" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //退出代码
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:userPlistZH]) {
            NSError *error = [NSError new];
            error = nil;
            [fileManager removeItemAtPath:userPlistZH error:&error];
            if (error) {
                [LCProgressHUD showMessage:@"惊现异常!重新退出!"];
                return ;
            }
            userdataGWL.username = @"";
            userdataGWL.true_name = @"";
            userdataGWL.telephone = @"";
            userdataGWL.area = @"";
            userdataGWL.contact_addr = @"";
            userdataGWL.qq = @"";
            userdataGWL.sex = @"";
            userdataGWL.birthday = @"";
            userdataGWL.group_id = @"";
            userdataGWL.exp = @"";
            userdataGWL.point = @"";
            userdataGWL.message_ids = @"";
            userdataGWL.zip = @"";
            userdataGWL.status = @"";
            userdataGWL.balance = @"";
            userdataGWL.ticket = @"";
            userdataGWL.email = @"";
            userdataGWL.prop_num = @"";
            userdataGWL.user_id = @"";
            userdataGWL.lohas = @"";
            userdataGWL.group_name = @"";
            [self.tableView reloadData];
            //判断用户登录的信息是否存在
            if ([[NSFileManager defaultManager]fileExistsAtPath:userPlistZH]) {
                //用登录的信息存在跳转到主页
            }else{
                GWLLoginViewController *loginVC = [[GWLLoginViewController alloc]initWithNibName:@"GWLLoginViewController" bundle:nil];
                [self.navigationController pushViewController:loginVC animated:NO];
            }
        }
    }];
    UIAlertAction *act2=[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [controller addAction:act1];
    [controller addAction:act2];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}
//提现
-(void)CashwithdrawalEvent{
    GWLCashwithdrawalViewController *cashVC = [[GWLCashwithdrawalViewController alloc]initWithNibName:@"GWLCashwithdrawalViewController" bundle:nil];
    cashVC.title = @"提现";
    [self.navigationController pushViewController:cashVC animated:YES];
    
}
//其他点击事件的处理
-(void)personalcenterCelltwobuttonEvent:(NSInteger)index{
    //currentIndex50到62分别是点击事件区分
    switch (index) {
        case 50:
            //我的订单
        {
            GWLMyOrderViewController *cashVC = [[GWLMyOrderViewController alloc]initWithNibName:@"GWLMyOrderViewController" bundle:nil];
            cashVC.title = @"我的订单";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 51:
            //余额明细
        {
            GWLBalanceViewController *cashVC = [[GWLBalanceViewController alloc]initWithNibName:@"GWLBalanceViewController" bundle:nil];
            cashVC.title = @"余额明细";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 52:
            //现在充值
        {
            GWLrechargeViewController *cashVC = [[GWLrechargeViewController alloc]initWithNibName:@"GWLrechargeViewController" bundle:nil];
            cashVC.title = @"在线充值";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 53:
            //个人资料
        {
            GWLUserDataViewController *cashVC = [[GWLUserDataViewController alloc]initWithNibName:@"GWLUserDataViewController" bundle:nil];
            cashVC.title = @"个人资料";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 54:
            //地址管理
        {
            GWLAddressManagementViewController *cashVC = [[GWLAddressManagementViewController alloc]initWithNibName:@"GWLAddressManagementViewController" bundle:nil];
            cashVC.title = @"地址管理";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 55:
            //修改密码
        {
            GWLModifyPasswordViewController *cashVC = [[GWLModifyPasswordViewController alloc]initWithNibName:@"GWLModifyPasswordViewController" bundle:nil];
            cashVC.title = @"修改密码";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 56:
            //资金转账
        {
            GWLTransferFundsViewController *cashVC = [[GWLTransferFundsViewController alloc]initWithNibName:@"GWLTransferFundsViewController" bundle:nil];
            cashVC.title = @"资金转账";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 57:
            //会员福利
        {
            GWLVIPWelfareViewController *cashVC = [[GWLVIPWelfareViewController alloc]initWithNibName:@"GWLVIPWelfareViewController" bundle:nil];
            cashVC.title = @"会员福利";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 58:
            //专属客服
        {
            GWLcustomerServiceViewController *cashVC = [[GWLcustomerServiceViewController alloc]initWithNibName:@"GWLcustomerServiceViewController" bundle:nil];
            cashVC.title = @"专属客服";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 59:
            //我要推广
        {
            GWLMYPromotionViewController *cashVC = [[GWLMYPromotionViewController alloc]initWithNibName:@"GWLMYPromotionViewController" bundle:nil];
            cashVC.title = @"我要推广";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 60:
            //专属分红
        {
            GWLExclusiveDividendViewController *cashVC = [[GWLExclusiveDividendViewController alloc]initWithNibName:@"GWLExclusiveDividendViewController" bundle:nil];
            cashVC.title = @"专属分红";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
        case 61:
            //乐豆专题
        {
            GWLLedouProjectViewController *cashVC = [[GWLLedouProjectViewController alloc]initWithNibName:@"GWLLedouProjectViewController" bundle:nil];
            cashVC.title = @"乐豆专题";
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 200;
    }else if (indexPath.section == 1){
        return 320;
    }else{
        return 60;
    }
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0;
}

////设置区尾视图
//-(nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=[UIColor clearColor];//透明颜色
//    return view;
//}
//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        static NSString *str=@"indexpathone";
        GWLpersonalCenterCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLpersonalCenterCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellone.homeVC = self;
        cellone.Ylabel01.text = userdataGWL.username;
        cellone.Ylabel02.text = userdataGWL.ticket;
        cellone.Ylabel03.text = userdataGWL.point;
        cellone.Ylabel04.text = userdataGWL.exp;
        cellone.Zlabel01.text = userdataGWL.balance;
        cellone.Zlabel02.text = userdataGWL.prop_num;
        cellone.Zlabel03.text = userdataGWL.lohas;
        cellone.zlabel04.text = userdataGWL.group_name;

        
        return cellone;
    }else if (indexPath.section ==1){
        static NSString *str=@"indexpathtwo";
        GWLpersonalcenterCelltwo *celltwo = [tableView dequeueReusableCellWithIdentifier:str];
        celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!celltwo) {
            celltwo = [[GWLpersonalcenterCelltwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
//        celltwo.homeVC = self;
//        celltwo.newsArray = [self.dataDicty objectForKey:@"news"];
        celltwo.homeVC = self;
        return celltwo;
    }else{
        static NSString *str=@"indexpaththree";
        GWLpersonalCenterCellthree *cellthree = [tableView dequeueReusableCellWithIdentifier:str];
        cellthree.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellthree) {
            cellthree = [[GWLpersonalCenterCellthree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellthree.homeVC = self;
        return cellthree;
    }
    
}



#pragma mark - UITableViewDataSource
//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//反选
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //     cell.selected = NO;
    NSLog(@"点击Cell了");
    
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
