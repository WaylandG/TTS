//
//  GWLDetailsModel.h
//  TTS
//
//  Created by Waylond.G on 2019/3/15.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GWLDetailsModel : NSObject
@property (nonatomic ,strong)NSString *s_id;//商品id
@property (nonatomic ,strong)NSString *name;//商品名字
@property (nonatomic ,strong)NSString *goods_no;//商品的货号
@property (nonatomic ,strong)NSString *model_id;//模型的ID
@property (nonatomic ,strong)NSString *sell_price;//销售价格
@property (nonatomic ,strong)NSString *market_price;//市场价格
@property (nonatomic ,strong)NSString *cost_price;//成本价格
@property (nonatomic ,strong)NSString *up_time;//上架时间
@property (nonatomic ,strong)NSString *down_time;//下加时间
@property (nonatomic ,strong)NSString *create_time;//创建时间
@property (nonatomic ,strong)NSString *store_nums;//库存
@property (nonatomic ,strong)NSString *img;//原图
@property (nonatomic ,strong)NSString *ad_img;//宣传图
@property (nonatomic ,strong)NSString *is_del;//商品状态0正常 1已删除2已下架3申请上架
@property (nonatomic ,strong)NSString *content;//商品描述
@property (nonatomic ,strong)NSString *content_imgsrc;//商品描述连接
@property (nonatomic ,strong)NSString *keywords;//seo关键词
@property (nonatomic ,strong)NSString *description_s;//SEO描述
@property (nonatomic ,strong)NSString *search_words;//产品搜索词d逗号隔开
@property (nonatomic ,strong)NSString *weight;//产品重量
@property (nonatomic ,strong)NSString *point;//积分
@property (nonatomic ,strong)NSString *unit;//计件单位如个件箱
@property (nonatomic ,strong)NSString *brand_id;//o品牌id
@property (nonatomic ,strong)NSString *allow_max_ticket;//购物劵最大使用量
@property (nonatomic ,strong)NSString *visit;//浏览次数
@property (nonatomic ,strong)NSString *favorite;//收藏次数
@property (nonatomic ,strong)NSString *sort;//排序
@property (nonatomic ,strong)NSString *spec_array;//序列化存储格式key值为规则id value为商品具有的价格值
@property (nonatomic ,strong)NSString *area;//排序
@property (nonatomic ,strong)NSString *exp;//经验值
@property (nonatomic ,strong)NSString *comments;//o评论次数
@property (nonatomic ,strong)NSString *sale;//销量
@property (nonatomic ,strong)NSString *grade;//评分总数
@property (nonatomic ,strong)NSString *seller_id;//卖家id
@property (nonatomic ,strong)NSString *is_share;//共享商品0不共享1共享
@property (nonatomic ,strong)NSString *is_delivery_fee;//m1免运费0不免费
@property (nonatomic ,strong)NSString *_hash;//预留散列字段
@property (nonatomic ,strong)NSString *lohas;//乐活
@property (nonatomic ,strong)NSString *g_point;//f得分
@property (nonatomic ,strong)NSString *ticket;//劵
@property (nonatomic ,strong)NSString *submit_money;//抵押款

@property (nonatomic ,strong)NSArray *photo;//轮播数组
@property (nonatomic ,strong)NSArray *attribute;

@end

NS_ASSUME_NONNULL_END
