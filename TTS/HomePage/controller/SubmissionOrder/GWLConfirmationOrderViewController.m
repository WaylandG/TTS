//
//  GWLConfirmationOrderViewController.m
//  TTS
//确认订单
//  Created by Waylond.G on 2019/3/26.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLConfirmationOrderViewController.h"

@interface GWLConfirmationOrderViewController ()
@property (weak, nonatomic) IBOutlet UIView *Z_view;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
@property (weak, nonatomic) IBOutlet UIView *view9;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UIButton *buttonZF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yuesutop;

@end

@implementation GWLConfirmationOrderViewController

-(void)viwebkx:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 0.25;
    view.layer.borderColor = [RGBColor(213, 213,215) CGColor];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 0.0;
}

- (void)viewWillAppear:(BOOL)animated{//隐藏tabbar
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{//显示tabbar
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self viwebkx:self.Z_view];
    [self viwebkx:self.view1];
    [self viwebkx:self.view2];
    [self viwebkx:self.view3];
    [self viwebkx:self.view4];
    [self viwebkx:self.view5];
    [self viwebkx:self.view6];
    [self viwebkx:self.view7];
    [self viwebkx:self.view8];
    [self viwebkx:self.view9];
    self.buttonZF.layer.masksToBounds = YES;
    self.buttonZF.layer.borderWidth = 0.25;
    self.buttonZF.layer.borderColor = [RGBColor(238, 66,123) CGColor];
    self.buttonZF.backgroundColor = RGBColor(238, 66,123);
    self.buttonZF.layer.cornerRadius = 0.0;
    if (@available(iOS 11.0, *)) {
        self.yuesutop.constant = 15.0;
    } else {
        
        
        
    }
}
- (IBAction)buttonZFEvent:(UIButton *)sender {
    [LCProgressHUD showMessage:@"等待支付接口调用"];
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
