//
//  YSCities.h
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/26.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCities : NSObject
@property (strong , nonatomic) NSDictionary *CityName;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)cityWithDict:(NSDictionary *)dict;
@end
