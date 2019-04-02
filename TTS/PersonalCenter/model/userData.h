//
//  userData.h
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface userData : NSObject
@property (nonatomic ,strong)NSString *user_id;//用户id
@property (nonatomic ,strong)NSString *username;//用户账号名
@property (nonatomic ,strong)NSString *true_name;//真实姓名telephone
@property (nonatomic ,strong)NSString *telephone;//联系电话
@property (nonatomic ,strong)NSString *area;//地区
@property (nonatomic ,strong)NSString *contact_addr;//联系地址
@property (nonatomic ,strong)NSString *qq;//QQ号
@property (nonatomic ,strong)NSString *sex;//性别1是男2是女
@property (nonatomic ,strong)NSString *birthday;//生日
@property (nonatomic ,strong)NSString *group_id;//分组id
@property (nonatomic ,strong)NSString *exp;//经验值
@property (nonatomic ,strong)NSString *point;//积分
@property (nonatomic ,strong)NSString *message_ids;//消息id
@property (nonatomic ,strong)NSString *zip;//邮编码
@property (nonatomic ,strong)NSString *status;//1正常2删除只回收站3锁定
@property (nonatomic ,strong)NSString *balance;//用户余额
@property (nonatomic ,strong)NSString *ticket;//提货券
@property (nonatomic ,strong)NSString *email;//password
@property (nonatomic ,strong)NSString *password;
@property (nonatomic ,strong)NSString *prop_num;
@property (nonatomic ,strong)NSString *lohas;//乐豆
@property (nonatomic ,strong)NSString *group_name;//等级会员

+(userData *)instance;


@end

NS_ASSUME_NONNULL_END
