//
//  YSCitysTableViewController.h
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/25.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockType)(NSString *str);

@interface YSCitysTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *citiesData;
// block反向传值的要求1：传值方定义block变量
@property (strong, nonatomic) BlockType block;
@end
