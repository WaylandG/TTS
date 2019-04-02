//
//  GWLLoginViewController.m
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLLoginViewController.h"

@interface GWLLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *uNamefield;
@property (weak, nonatomic) IBOutlet UITextField *Passwordfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

//用户信息
@property(nonatomic,strong) NSMutableDictionary * userdic;

@end

@implementation GWLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户登录";
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 3.0;
    self.loginButton.layer.borderWidth = 1.0;
    self.loginButton.backgroundColor = GWLMainRED_COLOR;
    self.loginButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    //判断用户登录的信息是否存在
    if ([[NSFileManager defaultManager]fileExistsAtPath:userPlistZH]) {
        //用登录的信息存在跳转到主页
        self.userdic = [NSMutableDictionary dictionaryWithContentsOfFile:userPlistZH];
        self.uNamefield.text= [self.userdic objectForKey:@"username"];
        self.Passwordfield.text = @"123456";
        NSLog(@"用户信息存在%@",self.userdic);
    }else{
        //用户没有登录
        self.uNamefield.text= @"";
        self.Passwordfield.text = @"";
    }
    
    [self registerForKeyboardNotifications];
    [self setUpTextField];
    
}

//登录按钮点击事件
- (IBAction)loginButtonEvent:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.uNamefield.text.length < 1) {
        [LCProgressHUD showMessage:@"手机号不能为空"];
        return;
    }
//    if (self.uNamefield.text.length < 11) {
//        [LCProgressHUD showMessage:@"手机号不足11位,请重新输入"];
//        return;
//    }
    if (self.Passwordfield.text.length < 1) {
        [LCProgressHUD showMessage:@"密码不能为空"];
        return;
    }
    if (self.Passwordfield.text.length < 6) {
        [LCProgressHUD showMessage:@"请输入至少6位密码"];
        return;
    }
    NSString *loginURL = [NSString stringWithFormat:@"%@Applogin/login",DomainName];
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
    [parame setObject:self.uNamefield.text forKey:@"login_info"];
    [parame setObject:self.Passwordfield.text forKey:@"password"];
    [parame setObject:@"1" forKey:@"remember"];
    [PPNetworkHelper POST:loginURL parameters:parame success:^(id responseObject) {
        NSLog(@"登录成功%@",responseObject);
        [LCProgressHUD showMessage:@"登录成功"];
        int flag = [[responseObject objectForKey:@"flag"] intValue];
        if (flag ==1) {
            //登录成功
            NSMutableDictionary *rowdic = [responseObject objectForKey:@"row"];
            userData *data = [userData mj_objectWithKeyValues:rowdic];
            userdataGWL.username = data.username;
            userdataGWL.true_name = data.true_name;
            userdataGWL.telephone = data.telephone;
            userdataGWL.area = data.area;
            userdataGWL.contact_addr = data.contact_addr;
            userdataGWL.qq = data.qq;
            userdataGWL.sex = data.sex;
            userdataGWL.birthday = data.birthday;
            userdataGWL.group_id = data.group_id;
            userdataGWL.exp = data.exp;
            userdataGWL.point = data.point;
            userdataGWL.message_ids = data.message_ids;
            userdataGWL.zip = data.zip;
            userdataGWL.status = data.status;
            userdataGWL.balance = data.balance;
            userdataGWL.ticket = data.ticket;
            userdataGWL.email = data.email;
            userdataGWL.prop_num = data.prop_num;
            userdataGWL.user_id = data.user_id;
            userdataGWL.lohas = data.lohas;
            userdataGWL.group_name = data.group_name;
            
            self.userdic = [responseObject objectForKey:@"row"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            if ([self.userdic isKindOfClass:[NSNull class]]) {
                //用户信息为空
                [LCProgressHUD showFailure:@"你的个人资料为空请联系管理员"];
                return ;
            }else{//返回信息正常
                //用户信息不为空
                if ([self isNullDic:self.userdic Key:@"username"]) {//用户账号名
                    [dic setObject:@"暂无" forKey:@"username"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"username"] forKey:@"username"];
                }
                
                if ([self isNullDic:self.userdic Key:@"true_name"]) {//真实姓名telephone
                    [dic setObject:@"暂无" forKey:@"true_name"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"true_name"] forKey:@"true_name"];
                }
                
                if ([self isNullDic:self.userdic Key:@"telephone"]) {//联系电话
                    [dic setObject:@"暂无" forKey:@"telephone"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"telephone"] forKey:@"telephone"];
                }
                
                if ([self isNullDic:self.userdic Key:@"area"]) {//地区
                    [dic setObject:@"暂无" forKey:@"area"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"area"] forKey:@"area"];
                }
                
                if ([self isNullDic:self.userdic Key:@"contact_addr"]) {//联系地址
                    [dic setObject:@"暂无" forKey:@"contact_addr"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"contact_addr"] forKey:@"contact_addr"];
                }
                
                if ([self isNullDic:self.userdic Key:@"qq"]) {//QQ号
                    [dic setObject:@"暂无" forKey:@"qq"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"qq"] forKey:@"qq"];
                }
                
                if ([self isNullDic:self.userdic Key:@"sex"]) {//性别1是男2是女
                    [dic setObject:@"暂无" forKey:@"sex"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"sex"] forKey:@"sex"];
                }
                
                if ([self isNullDic:self.userdic Key:@"birthday"]) {//生日
                    [dic setObject:@"暂无" forKey:@"birthday"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"birthday"] forKey:@"birthday"];
                }
                
                if ([self isNullDic:self.userdic Key:@"group_id"]) {//分组id
                    [dic setObject:@"暂无" forKey:@"group_id"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"group_id"] forKey:@"group_id"];
                }
                
                if ([self isNullDic:self.userdic Key:@"exp"]) {//经验值
                    [dic setObject:@"暂无" forKey:@"exp"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"exp"] forKey:@"exp"];
                }
                
                if ([self isNullDic:self.userdic Key:@"point"]) {//积分
                    [dic setObject:@"暂无" forKey:@"point"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"point"] forKey:@"point"];
                }
                if ([self isNullDic:self.userdic Key:@"message_ids"]) {//消息id
                    [dic setObject:@"暂无" forKey:@"message_ids"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"message_ids"] forKey:@"message_ids"];
                }
                
                if ([self isNullDic:self.userdic Key:@"zip"]) {//邮编码
                    [dic setObject:@"暂无" forKey:@"zip"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"zip"] forKey:@"zip"];
                }
                
                if ([self isNullDic:self.userdic Key:@"status"]) {//1正常2删除只回收站3锁定
                    [dic setObject:@"暂无" forKey:@"status"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"status"] forKey:@"status"];
                }
                if ([self isNullDic:self.userdic Key:@"balance"]) {//用户余额
                    [dic setObject:@"暂无" forKey:@"balance"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"balance"] forKey:@"balance"];
                }
                
                if ([self isNullDic:self.userdic Key:@"ticket"]) {//提货劵
                    [dic setObject:@"暂无" forKey:@"ticket"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"ticket"] forKey:@"ticket"];
                }
                
                if ([self isNullDic:self.userdic Key:@"email"]) {//邮箱
                    [dic setObject:@"暂无" forKey:@"email"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"email"] forKey:@"email"];
                }
                
                if ([self isNullDic:self.userdic Key:@"password"]) {//密码
                    [dic setObject:@"暂无" forKey:@"password"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"password"] forKey:@"password"];
                }
                
                if ([self isNullDic:self.userdic Key:@"prop_num"]) {//代金券
                    [dic setObject:@"暂无" forKey:@"prop_num"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"prop_num"] forKey:@"prop_num"];
                }
                if ([self isNullDic:self.userdic Key:@"user_id"]) {//代金券
                    [dic setObject:@"暂无" forKey:@"user_id"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"user_id"] forKey:@"user_id"];
                }
                
                if ([self isNullDic:self.userdic Key:@"lohas"]) {//乐豆
                    [dic setObject:@"暂无" forKey:@"lohas"];
                }else{
                    [dic setObject:[self.userdic objectForKey:@"lohas"] forKey:@"lohas"];
                }
                if ([self isNullDic:self.userdic Key:@"group_name"]) {//当前等级
                    [dic setObject:@"VIP会员" forKey:@"group_name"];
                    userdataGWL.group_name = @"VIP会员";
                }else{
                    [dic setObject:[self.userdic objectForKey:@"group_name"] forKey:@"group_name"];
                }
                
            }
            //要保存的用户信息
            NSLog(@"地址%@",userPlistZH);
            NSLog(@"userdic%@",dic);
            [dic writeToFile:userPlistZH atomically:YES];
            [self.navigationController popViewControllerAnimated:NO];
        }else{//登录出现错误
            [LCProgressHUD showMessage:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]]];
            
        }
    } failure:^(NSError *error) {
         NSLog(@"登录失败%@",error);
    }];
}

//判断字典是否为空
-(BOOL)isNullDic:(NSMutableDictionary *)dic Key:(NSString *)key{
    
    NSString *string = [dic objectForKey:key];
    //    string = [string stringByReplacingOccurrencesOfString: @" " withString: @""];
    if ([dic isKindOfClass:[NSNull class]] ||[self isBlankString:string]) {
        return YES;
    }else{
        return NO;
    }
}

//注册
- (IBAction)registerButtonEvent:(UIButton *)sender {
}

//找回密码
- (IBAction)reetrievePasswordButtonEvent:(UIButton *)sender {
}



#pragma mark - 键盘的监听
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setTF:)
                                                 name:@"changetextfield" object:nil];
}

- (void)setTF:(NSNotification *)noti{
    NSString *title = noti.object;
    self.uNamefield.text = title;
}

- (void)setUpTextField
{
    self.uNamefield.delegate = self;
    self.Passwordfield.delegate = self;
    [self.uNamefield addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.Passwordfield addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textfield
{
    if ([textfield isEqual:self.uNamefield]) {
        if (textfield.text.length <=16) {
        } else {
            NSString *subText = [textfield.text substringToIndex:17-1];
            textfield.text = subText;
        }
    }
    
    if ([textfield isEqual:self.Passwordfield]) {
        if (textfield.text.length <= 18) {
        } else {
            NSString *subText = [textfield.text substringToIndex:18];
            textfield.text = subText;
        }
    }
}

#pragma mark - 键盘通知
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *userInfo = aNotification.userInfo;
    NSTimeInterval time = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect keboard = [userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    CGFloat height = keboard.size.height;
    
    
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = - height/2;
        self.view.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    NSDictionary *userInfo = aNotification.userInfo;
    NSTimeInterval time = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    
}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!string) {
        return YES;
    }
    //    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
    //        return YES;
    //    }
    return NO;
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
