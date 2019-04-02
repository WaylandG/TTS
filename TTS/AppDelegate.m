//
//  AppDelegate.m
//  TTS
//
//  Created by Waylond.G on 2019/3/1.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "AppDelegate.h"
#import "GWLHomePageViewController.h"
#import "GWLShoppMallViewController.h"
#import "GWLShoppCartViewController.h"
#import "GWLPersonalCenterViewController.h"



@interface AppDelegate ()
//用户信息
@property(nonatomic,strong) NSMutableDictionary * userdic;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%f",ScreenWidth);
    UIColor *navColor = GWLMainRED_COLOR;
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateNormal];
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    GWLHomePageViewController *homepageVC = [[GWLHomePageViewController alloc] initWithNibName:@"GWLHomePageViewController" bundle:nil];
    UINavigationController *naviHomePage = [[UINavigationController alloc] initWithRootViewController:homepageVC];
    GWLShoppMallViewController *shoppmallVC = [[GWLShoppMallViewController alloc] initWithNibName:@"GWLShoppMallViewController" bundle:nil];
    UINavigationController *naviShoppMall = [[UINavigationController alloc]initWithRootViewController:shoppmallVC];
    GWLShoppCartViewController *shoppcartVC = [[GWLShoppCartViewController alloc]initWithNibName:@"GWLShoppCartViewController" bundle:nil];
    UINavigationController *naviShoppCart = [[UINavigationController alloc] initWithRootViewController:shoppcartVC];
    GWLPersonalCenterViewController *percenterVC = [[GWLPersonalCenterViewController alloc]initWithNibName:@"GWLPersonalCenterViewController" bundle:nil];
    UINavigationController *naviPercenter = [[UINavigationController alloc]initWithRootViewController:percenterVC];
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.tabBar.tintColor = GWLMainRED_COLOR;
//    [[UITabBar appearance] setBackgroundColor:GWLMainRED_COLOR];
//    [[UITabBar appearance] setBarTintColor:GWLMainRED_COLOR];
    tabbar.viewControllers = @[naviHomePage,naviShoppMall,naviShoppCart,naviPercenter];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
  
    
//    NSString *urlString = [[NSString alloc]initWithFormat:@"%@/appiface/index",DomainName];
//    
//    [PPNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
//        NSLog(@"请求成功%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"请求失败%@",error);
//    }];
    
//    [PPNetworkHelper GET:@"http://wie9et.natappfree.cc/appiface/index" parameters:nil success:^(id responseObject) {
//        NSLog(@"请求成功%@",responseObject);
//    } failure:^(NSError *error) {
//         NSLog(@"请求失败%@",error);
//    }];
    [self userInformationAcquisition];
    return YES;
}

//用户信息获取
-(void)userInformationAcquisition{
    //判断用户登录的信息是否存在
    if ([[NSFileManager defaultManager]fileExistsAtPath:userPlistZH]) {
        //用登录的信息存在跳转到主页
        self.userdic = [NSMutableDictionary dictionaryWithContentsOfFile:userPlistZH];
        NSLog(@"用户信息存在%@",self.userdic);
        NSMutableDictionary *rowdic = [NSMutableDictionary dictionaryWithContentsOfFile:userPlistZH];
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
        userdataGWL.password = data.password;
        userdataGWL.prop_num = data.prop_num;
        userdataGWL.user_id = data.user_id;
        userdataGWL.lohas = data.lohas;
        userdataGWL.group_name = data.group_name;
        
        //信息用法
//        userData *uus = [userData instance];
        NSLog(@"%@",userdataGWL.password);
        
    }else{
        NSLog(@"用没有登录");
    }
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TTS"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
