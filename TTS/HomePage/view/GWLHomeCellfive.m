//
//  GWLHomeCellfive.m
//  TTS
//
//  Created by Waylond.G on 2019/3/11.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "GWLHomeCellfive.h"

@implementation GWLHomeCellfive
-(void)setNewsArray:(NSArray *)newsArray{
    _newsArray = newsArray;
    if (!_newsArray) {
        for (int i = 0; i<_newsArray.count; i++) {
            
        }
        
    }
    
}
//-(void)setRec_sec_t:(NSString *)rec_sec_t{
//    _rec_sec_t = rec_sec_t;
//    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=[UIColor clearColor];//透明颜色
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.viewd.frame.size.width, 30)];
//    lbl.text = self.rec_first_t;
//    lbl.textAlignment=NSTextAlignmentCenter;
//    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
//    [self addSubview:lbl];
//    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.viewd.frame.size.width, 30)];
//    lb2.text = self.rec_sec_t;
//    lb2.textAlignment=NSTextAlignmentCenter;
//    lb2.font = [UIFont systemFontOfSize:12.0];
//    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lb2.textColor = RGBColor(217, 217, 217);
//    [self addSubview:lb2];
//
//}
//-(void)setRec_first_t:(NSString *)rec_first_t{
//    _rec_first_t = rec_first_t;
//    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=[UIColor clearColor];//透明颜色
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.viewd.frame.size.width, 30)];
//    lbl.text = self.rec_first_t;
//    lbl.textAlignment=NSTextAlignmentCenter;
//    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
//    [self addSubview:lbl];
//    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.viewd.frame.size.width, 30)];
//    lb2.text = self.rec_sec_t;
//    lb2.textAlignment=NSTextAlignmentCenter;
//    lb2.font = [UIFont systemFontOfSize:12.0];
//    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lb2.textColor = RGBColor(217, 217, 217);
//    [self addSubview:lb2];
//
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    NSDictionary *dic = self.rec_parray[section-4];
    
//    UIView *view=[[UIView alloc]init];
//    view.backgroundColor=[UIColor clearColor];//透明颜色
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.viewd.frame.size.width, 30)];
//    lbl.text = self.rec_first_t;
//    lbl.textAlignment=NSTextAlignmentCenter;
//    lbl.textColor=[self colorWithHexString:@"#2c2c2c"];
//    [self addSubview:lbl];
//    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.viewd.frame.size.width, 30)];
//    lb2.text = self.rec_sec_t;
//    lb2.textAlignment=NSTextAlignmentCenter;
//    lb2.font = [UIFont systemFontOfSize:12.0];
//    //    lb2.textColor=[self colorWithHexString:@"#2c2c2c"];
//    lb2.textColor = RGBColor(217, 217, 217);
//    [self addSubview:lb2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
