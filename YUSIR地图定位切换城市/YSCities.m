//
//  YSCities.m
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/26.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSCities.h"

@implementation YSCities


-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self= [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)cityWithDict:(NSDictionary *)dict
{
        return [[self alloc] initWithDict:dict];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
