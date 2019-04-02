//
//  GWLModifyPasswordViewController.m
//  TTS
//密码修改
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLModifyPasswordViewController.h"

@interface GWLModifyPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;
@property (weak, nonatomic) IBOutlet UITextField *field3;
@property (weak, nonatomic) IBOutlet UIButton *button_O;

@end

@implementation GWLModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerForKeyboardNotifications];
    [self setUpTextField];
}

- (IBAction)button_OEvent:(UIButton *)sender {
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{//显示tabbar
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
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
    self.field1.text = title;
}

- (void)setUpTextField
{
    self.field1.delegate = self;
    self.field2.delegate = self;
    self.field3.delegate = self;
    [self.field1 addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.field2 addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.field3 addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textfield
{
    if ([textfield isEqual:self.field1]) {
        if (textfield.text.length <=16) {
        } else {
            NSString *subText = [textfield.text substringToIndex:17-1];
            textfield.text = subText;
        }
    }
    
    if ([textfield isEqual:self.field2]) {
        if (textfield.text.length <= 18) {
        } else {
            NSString *subText = [textfield.text substringToIndex:18];
            textfield.text = subText;
        }
    }
    
    if ([textfield isEqual:self.field3]) {
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
