//
//  YSProvinces.h
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/28.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSCities;
@interface YSProvinces : NSObject

@property (nonatomic,strong) NSString* ProvinceName;
@property (nonatomic,strong) YSCities* cities;

@end
