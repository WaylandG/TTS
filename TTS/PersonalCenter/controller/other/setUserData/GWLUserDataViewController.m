//
//  GWLUserDataViewController.m
//  TTS
//个人资料
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLUserDataViewController.h"
#import "LDuserTableViewCell.h"

@interface GWLUserDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *nameArray;
@property(nonatomic,strong)NSMutableDictionary *userdic;

@property (nonatomic,copy) NSString *sign;

//退出登录
@property (weak, nonatomic) IBOutlet UIButton *TCDLButton;

@property (nonatomic ,strong)UIImage *image;


@end

@implementation GWLUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameArray = @[@"头像",@"姓名",@"性别",@"生日",@"地区",@"地址",@"手机",@"邮编",@"电话",@"QQ"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LDuserTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = RGBColor(234, 235, 237);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.TCDLButton.backgroundColor = GWLMainRED_COLOR;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"保存的用户信息%@",self.userdic);
    [self.tableView reloadData];
     self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{//显示tabbar
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark - tableview的代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //有几个区
    return self.nameArray.count;
}
//每个区有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//每行的内容是啥
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDuserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.labelName.text = self.nameArray[indexPath.section];
    
    
    if (indexPath.section ==0) {
//        [cell.nameImage sd_setImageWithURL:self.image placeholderImage:[UIImage imageNamed:@"loading"]];
        if (self.image) {
            cell.nameImage.image = self.image;
        }else{
            cell.nameImage.image = [UIImage imageNamed:@"loading"];
        }
    
    }else{
        cell.nameImage.hidden = YES;
        if (indexPath.section ==1) {
            cell.labelN.text = userdataGWL.true_name;
        }else if (indexPath.section ==2){
            if ([userdataGWL.sex isEqualToString:@"1"]) {
                cell.labelN.text = @"男";
            }else{
                cell.labelN.text = @"女";
            }
//            cell.labelN.text = userdataGWL.sex;
        }else if (indexPath.section ==3){
            cell.labelN.text = userdataGWL.birthday;
        }
        else if (indexPath.section ==4){
            cell.labelN.text = userdataGWL.area;
        }else if (indexPath.section ==5){
            cell.labelN.text = userdataGWL.contact_addr;
        }else if (indexPath.section ==6){
            cell.labelN.text = userdataGWL.telephone;
        }else if (indexPath.section ==7){
            cell.labelN.text = userdataGWL.email;
        }else if (indexPath.section ==8){
            cell.labelN.text = userdataGWL.telephone;
        }else if (indexPath.section ==9){
            cell.labelN.text = userdataGWL.qq;
        }
        else{
            cell.labelN.text =self.nameArray[indexPath.section];
        }
        
        
        
        
    }
    return cell;
}
//行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 90;
    }else{
        return 52;
    }
}
//行高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==9) {
        return 0;
    }else{
        return 0;
    }
}

#pragma mark - UITableViewDelegate代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog(@"想要查看");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;

    if (indexPath.section ==0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        actionSheet.delegate = self;
        [actionSheet addButtonWithTitle:NSLocalizedString(@"拍照", nil)];
        [actionSheet addButtonWithTitle:NSLocalizedString(@"从相册中选取", nil)];
        //actionSheet.tag = 0911;
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:NSLocalizedString(@"取消", nil)];
        actionSheet.tag = 2017;
        [actionSheet showInView:self.view];
        
    }else{
        [LCProgressHUD showMessage:@"你暂时不能修改"];
        //[LCProgressHUD showMessage:[NSString stringWithFormat:@"暂不能进行%@",self.nameArray[indexPath.section]]];
//        userModifyViewController * VC = [[userModifyViewController alloc]initWithNibName:@"userModifyViewController" bundle:nil];
//        if (indexPath.section ==2) {
//            VC.title =@"修改联系方式";
//            VC.code = 2;
//            VC.xiuGName = @"contact";
//        }else if (indexPath.section ==1){
//            VC.title =@"修改单位名称";
//            VC.code = 1;
//            VC.xiuGName = @"company";
//        }else if (indexPath.section ==3){
//            VC.title =@"修改姓名";
//            VC.code = 3;
//            VC.xiuGName = @"name";
//        }
//        else if (indexPath.section ==4){
//            VC.title =@"修改手机号码";
//            VC.code = 4;
//            VC.xiuGName = @"telephone";
//        }else if (indexPath.section ==5){
//            VC.title =@"修改职务";
//            VC.code = 5;
//            VC.xiuGName = @"position";
//        }else if (indexPath.section ==6){
//            VC.title =@"修改注册码";
//            VC.code = 6;
//            VC.xiuGName = @"regnum";
//        }else if (indexPath.section ==7){
//            VC.title =@"修改密码";
//            VC.code = 7;
//            VC.xiuGName = @"changePwd";
//        }
//        else{
//            //cell.labelN.text =self.nameArray[indexPath.section];
//            [LCProgressHUD showInfoMsg:@"啥鬼！"];
//        }
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                                 style:UIBarButtonItemStylePlain
//                                                                                target:self
//                                                                                action:nil];
//        [self.navigationController pushViewController:VC animated:YES];
//
        
        
        
        
        
    }
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 2017) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
//                    [self pickImageFromCamera];
                    
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                    [self pickImageFromAlbum];
                    break;
                    
                default:
                    return;
                    break;
            }
            
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        
        if (self.tabBarController) {
            [self.tabBarController presentViewController:imagePickerController animated:YES completion:nil];
        }else{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        
    }else if (actionSheet.tag ==2018){
        switch (buttonIndex)
        {
            case 0:
                //退出
                NSLog(@"退出");
                
                break;
            case 1:
                NSLog(@"取消了®");
                break;
                
            default:
                return;
                break;
        }
        
        
        
    }
    
    
}
//用户选取图片之后回调的方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    
   
    NSData *data =UIImageJPEGRepresentation(photoImg, 0.5);
    self.image = [UIImage imageWithData:data];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    

}







#pragma mark 上传图片的数据请求
- (void)upLoaduserPhoto:(NSData *)imageData
{
    //[SVProgressHUD showWithStatus:@""];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIImage *image = [UIImage imageWithData:imageData];
    //    self.image = image;
    //    [self.userImageButton setImage:image forState:UIControlStateNormal];
    imageData = UIImageJPEGRepresentation(image, 0);
    NSString *image_Data = [imageData base64EncodedStringWithOptions:0];
    // NSLog(@"image_data %@",image_Data);
    NSString *im = [NSString stringWithFormat:@"data:image/jpg;base64,%@",image_Data];
    //用户选取到图片
//    imageV.image = image;
}
//yeshiniubbidaobuzing  zhende henkun wodetian


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 退出登录

- (IBAction)TCDLbuttonEvent:(UIButton *)sender {
    // 方法1 无代理，只有2个确定按钮
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"温馨提示你要保存信息吗？" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定保存" otherButtonTitles:nil];
    actionsheet.tag = 2018;
    actionsheet.delegate = self;
    [actionsheet showInView:self.view];
    
    
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
