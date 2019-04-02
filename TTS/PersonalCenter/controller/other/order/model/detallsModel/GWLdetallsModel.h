//
//  GWLdetallsModel.h
//  TTS
//
//  Created by Waylond.G on 2019/3/17.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLdetallsModel : NSObject
@property (nonatomic ,strong)NSString *accept_name;//商品id
@property (nonatomic ,strong)NSString *accept_time;//商品名字
@property (nonatomic ,strong)NSString *active_id;//商品的货号
@property (nonatomic ,strong)NSString *address;//模型的ID
@property (nonatomic ,strong)NSString *area;//销售价格
@property (nonatomic ,strong)NSString *area_str;//市场价格
@property (nonatomic ,strong)NSString *checkcode;//成本价格
@property (nonatomic ,strong)NSString *city;//上架时间
@property (nonatomic ,strong)NSString *city_str;//下加时间
@property (nonatomic ,strong)NSString *completion_time;//创建时间
@property (nonatomic ,strong)NSString *contact_addr;//库存
@property (nonatomic ,strong)NSString *country;//原图
@property (nonatomic ,strong)NSString *create_time;//宣传图
@property (nonatomic ,strong)NSString *currency;//商品状态0正常 1已删除2已下架3申请上架
@property (nonatomic ,strong)NSString *delivery;//商品描述
@property (nonatomic ,strong)NSString *discount;//商品描述连接
@property (nonatomic ,strong)NSString *distribution;//seo关键词
@property (nonatomic ,strong)NSString *distribution_status;//SEO描述
@property (nonatomic ,strong)NSString *email;//产品搜索词d逗号隔开
@property (nonatomic ,strong)NSString *exp;//产品重量
@property (nonatomic ,strong)NSString *goods_amount;//积分
@property (nonatomic ,strong)NSString *goods_weight;//计件单位如个件箱
@property (nonatomic ,strong)NSString *id_s;//o品牌id
@property (nonatomic ,strong)NSString *if_del;//购物劵最大使用量
@property (nonatomic ,strong)NSString *insured;//浏览次数
@property (nonatomic ,strong)NSString *invoice;//收藏次数
@property (nonatomic ,strong)NSString *invoice_info;//排序
@property (nonatomic ,strong)NSString *is_checkout;//序列化存储格式key值为规则id value为商品具有的价格值
@property (nonatomic ,strong)NSString *is_tui;//排序
@property (nonatomic ,strong)NSString *mobile;//经验值
@property (nonatomic ,strong)NSString *note;//o评论次数
@property (nonatomic ,strong)NSString *order_amount;//销量
@property (nonatomic ,strong)NSString *order_id;//评分总数
@property (nonatomic ,strong)NSString *order_no;//卖家id
@property (nonatomic ,strong)NSString *order_status;//共享商品0不共享1共享
@property (nonatomic ,strong)NSString *pay_fee;//m1免运费0不免费
@property (nonatomic ,strong)NSString *pay_status;//预留散列字段
@property (nonatomic ,strong)NSString *pay_time;//乐活
@property (nonatomic ,strong)NSString *pay_type;//f得分
@property (nonatomic ,strong)NSString *payable_amount;//劵
@property (nonatomic ,strong)NSString *payable_freight;//抵押款

@property (nonatomic ,strong)NSString *payment;//轮播数组
@property (nonatomic ,strong)NSString *paynote;

@property (nonatomic ,strong)NSString *point;//排序
@property (nonatomic ,strong)NSString *postcode;//经验值
@property (nonatomic ,strong)NSString *postscript;//o评论次数
@property (nonatomic ,strong)NSString *promotions;//销量
@property (nonatomic ,strong)NSString *prop;//评分总数
@property (nonatomic ,strong)NSString *prorule_ids;//卖家id
@property (nonatomic ,strong)NSString *province;//共享商品0不共享1共享
@property (nonatomic ,strong)NSString *province_str;//m1免运费0不免费
@property (nonatomic ,strong)NSString *real_amount;//预留散列字段
@property (nonatomic ,strong)NSString *real_freight;//乐活
@property (nonatomic ,strong)NSString *seller_id;//f得分
@property (nonatomic ,strong)NSString *send_time;//劵
@property (nonatomic ,strong)NSString *spend_point;//抵押款

@property (nonatomic ,strong)NSString *status;//轮播数组
@property (nonatomic ,strong)NSString *takeself;

@property (nonatomic ,strong)NSString *taxes;//评分总数
@property (nonatomic ,strong)NSString *telphone;//卖家id
@property (nonatomic ,strong)NSString *ticket;//共享商品0不共享1共享
@property (nonatomic ,strong)NSString *trade_no;//m1免运费0不免费
@property (nonatomic ,strong)NSString *true_name;//预留散列字段
@property (nonatomic ,strong)NSString *type;//乐活
@property (nonatomic ,strong)NSString *u_mobile;//f得分
@property (nonatomic ,strong)NSString *user_id;//劵
@property (nonatomic ,strong)NSString *username;//抵押款



@end

NS_ASSUME_NONNULL_END
