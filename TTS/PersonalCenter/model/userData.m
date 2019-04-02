//
//  userData.m
//  TTS
//
//  Created by Waylond.G on 2019/3/13.
//  Copyright © 2019 FeiboteElectronic. All rights reserved.
//

#import "userData.h"

@implementation userData

static userData* shareInstance = nil;

//第一种方法
+(userData *)instance{
    if (shareInstance == nil) {
        shareInstance = [[userData alloc]init];
    }
    return shareInstance;
}

////第二种方法
//+(instancetype)shareInstance{
//    static dispatch_once_t oncetken;
//    dispatch_once(&oncetken, ^{
//        shareInstance = [[userData alloc]init];
//    });
//    return shareInstance;
//}

@end
