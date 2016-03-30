//
//  YSProvinces.m
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/28.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSProvinces.h"

@implementation YSProvinces

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

+(instancetype)provinceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

//+(NSArray *)provinceList
//{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Provineces" ofType:@"plist"];
//    NSArray *provinceArray = [NSArray arrayWithContentsOfFile:filePath];
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (NSDictionary *provinceDict in provinceArray) {
//        WLProvince *province = [WLProvince provinceWithDict:provinceDict];
//        NSMutableArray *cityArray = [NSMutableArray array];
//        for (NSDictionary *cityDict in province.cities) {
//            WLCity *city = [WLCity cityWithDict:cityDict];
//            [cityArray addObject:city];
//        }
//        province.cities = cityArray;
//        [tempArray addObject:province];
//    }
//    return tempArray;
//}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
