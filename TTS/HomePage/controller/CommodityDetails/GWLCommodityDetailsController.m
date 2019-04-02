//
//  GWLCommodityDetailsController.m
//  TTS
//商品详情
//  Created by Waylond.G on 2019/3/12.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLCommodityDetailsController.h"
#import "GWLDetailsCellone.h"
#import "GWLDetailsCelltwo.h"
#import "GWLDetailsCellthree.h"
#import "GWLDetailsCellfour.h"
#import "GWLDetailsModel.h"
#import "GWLSubmissionOrderViewController.h"

@interface GWLCommodityDetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LJGMButton;
@property (weak, nonatomic) IBOutlet UIButton *JRGWCButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yueshu;

@property (nonatomic,strong)  GWLDetailsModel *model;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *dataDicty;

//详情图片
@property(nonatomic ,strong)UIImageView *XQimageview;
@property(nonatomic ,strong)UIImage *XQimage;
@end

@implementation GWLCommodityDetailsController

-(NSMutableDictionary *)dataDicty{
    if (!_dataDicty) {
        _dataDicty = [NSMutableDictionary dictionary];
    }
    return _dataDicty;
}

-(UIImageView *)XQimageview{
    if (_XQimageview) {
        _XQimageview = [[UIImageView alloc]init];
    }
    return _XQimageview;
}

//立即购买和加入购物车点击事件
- (IBAction)LIGMandJRGWCButtonEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 10001://立即购买
        {
            GWLSubmissionOrderViewController *VC= [[GWLSubmissionOrderViewController alloc]initWithNibName:@"GWLSubmissionOrderViewController" bundle:nil];
            VC.title = @"填写和提交订单信息";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 10002://加入购物车
        {
            [LCProgressHUD showMessage:@"等待调用接口"];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        // self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //self.sahngyueshu.constant =self.sahngyueshu.constant-40;
    } else {
        //self.automaticallyAdjustsScrollViewInsets = NO;
        if (self.tableView.frame.size.height == [UIScreen mainScreen].bounds.size.height) {
            self.yueshu.constant =self.navigationController.navigationBar.frame.size.height+20;
        }else{
            self.yueshu.constant =self.navigationController.navigationBar.frame.size.height+20;
        }
    }
    
    [self buttonSetJIGOW];
    //数据加载
    [self requestServerDataReset];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetailsCellone" bundle:nil] forCellReuseIdentifier:@"indexpathone"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetailsCelltwo" bundle:nil] forCellReuseIdentifier:@"indexpathtwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetailsCellthree" bundle:nil] forCellReuseIdentifier:@"indexpaththree"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GWLDetailsCellfour" bundle:nil] forCellReuseIdentifier:@"indexpathfour"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"GWLHomeCellfive" bundle:nil] forCellReuseIdentifier:@"indexpathfive"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=YES;
    [self.view addSubview:_tableView];
    
    //点击事件的监听
    __weak __typeof__(self) weakSelf = self;
    self.clickItemOperationhomeBlock = ^(id  _Nonnull calss, NSInteger currentIndex) {
        [weakSelf buttonEvent:calss :currentIndex];
    };
}

//按钮设置
-(void)buttonSetJIGOW{
    self.LJGMButton.backgroundColor = RGBColor(239, 63, 122);
    
    self.JRGWCButton.backgroundColor = RGBColor(97, 192, 209);
    
}

//点击事件的处理
-(void)buttonEvent:(id)calss :(NSInteger)currentIndex{
    if ([calss isKindOfClass:[GWLDetailsCellthree class]]) {
        switch (currentIndex) {
            case 0:{
                [self imagquest];
            }
                
                break;
            case 1:{
                self.XQimage = nil;
                [self.tableView reloadData];
            }
                
                break;
            case 2:{
                self.XQimage = nil;
                [self.tableView reloadData];
            }
                
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - 数据请求
-(void)requestServerDataReset{
    NSString *url = [NSString stringWithFormat:@"%@appiface/product",DomainName];
    NSLog(@"%@",url);
    NSMutableDictionary *parame = [[NSMutableDictionary alloc]init];
    if ([self isBlankString:self.id_s]) {
        [LCProgressHUD showMessage:@"商品ID为空"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [parame setObject:self.id_s forKey:@"id"];
    [PPNetworkHelper POST:url parameters:parame success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.dataDicty = responseObject;
        self.model = [GWLDetailsModel mj_objectWithKeyValues:responseObject];
        if (self.model.content_imgsrc) {
            [self imagquest];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(void) imagquest{
    self.XQimage = [UIImage imageNamed:@"sjiazai"];
    UIImageView*image=[[UIImageView alloc]init];
    __weak __typeof__(self) weakSelf = self;
    [image sd_setImageWithURL:[NSURL URLWithString:self.model.content_imgsrc] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize size=image.size;NSLog(@"%f%f",size.width,size.height);
        weakSelf.XQimage=[self imageCompressForWidth:image targetWidth:ScreenWidth];;
        [weakSelf.tableView reloadData];
    }];
    [self.view addSubview:image];
}

//指定宽度按比例缩放
-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UITableViewDelegate

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if (section ==3) {
            return 1;
        }else {
    return 1;
        }
}

//返回区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 365;
    }else if (indexPath.section == 1){
        return 330;
    }else if (indexPath.section == 2){
        return 100;
    }else if (indexPath.section == 3){
        return self.XQimage.size.height;
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
    return 1;
}
//设置区头视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary *dic = self.rec_parray[section-4];
//
    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=[UIColor clearColor];//透明颜色
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    lbl.text = [dic objectForKey:@"rec_first_t"];
//    lbl.textAlignment=NSTextAlignmentCenter;
//    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
//    [view addSubview:lbl];
//    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
//    lb2.text = [dic objectForKey:@"rec_sec_t"];
//    lb2.textAlignment=NSTextAlignmentCenter;
//    lb2.font = [UIFont systemFontOfSize:12.0];
//    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lb2.textColor = RGBColor(217, 217, 217);
//    [view addSubview:lb2];
    
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
        GWLDetailsCellone *cellone = [tableView dequeueReusableCellWithIdentifier:str];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellone) {
            cellone = [[GWLDetailsCellone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellone.homeVC= self;
        cellone.slideArray = [self.dataDicty objectForKey:@"photo"];
        
        return cellone;
    }else if (indexPath.section ==1){
        static NSString *str=@"indexpathtwo";
        GWLDetailsCelltwo *celltwo = [tableView dequeueReusableCellWithIdentifier:str];
        celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!celltwo) {
            celltwo = [[GWLDetailsCelltwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        celltwo.homeVC = self;
        celltwo.label1.text = self.model.name;
        celltwo.label2.text = self.model.sell_price;
        celltwo.label3.text = self.model.market_price;
        celltwo.label4.text = self.model.goods_no;
        celltwo.label5.text = self.model.store_nums;
        celltwo.label6.text = self.model.area;
        celltwo.label7.text = self.model.weight;
        celltwo.label8.text = [NSString stringWithFormat:@"%@ 次",self.model.comments];
        celltwo.label9.text = [NSString stringWithFormat:@"%@ %@",self.model.sale,self.model.unit];


        return celltwo;
    }else if (indexPath.section ==2){
        static NSString *str=@"indexpaththree";
        GWLDetailsCellthree *cellthree = [tableView dequeueReusableCellWithIdentifier:str];
        cellthree.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cellthree) {
            cellthree = [[GWLDetailsCellthree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cellthree.homeVC = self;
        return cellthree;
    }else{
        static NSString *str=@"indexpathfour";
        GWLDetailsCellfour *cellfour = [tableView dequeueReusableCellWithIdentifier:str];
        cellfour.selectionStyle = UITableViewCellSelectionStyleNone;
        cellfour.homeVC = self;
        cellfour.Viewimage.image = self.XQimage;
        return cellfour;
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


- (void)viewWillAppear:(BOOL)animated{//隐藏tabbar
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{//显示tabbar
    
    self.tabBarController.tabBar.hidden = NO;
    
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
