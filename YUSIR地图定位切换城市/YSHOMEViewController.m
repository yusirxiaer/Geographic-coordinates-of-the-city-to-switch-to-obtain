//
//  YSHOMEViewController.m
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/25.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSHOMEViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YSCitysTableViewController.h"
@interface YSHOMEViewController ()<CLLocationManagerDelegate>
@property (strong , nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
/**
*  地理编码
*/
@property (strong, nonatomic) CLGeocoder *geocoder;

@end

@implementation YSHOMEViewController
#pragma mark - 懒加载
- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
-(CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
#pragma mark - viewDidload配置
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocationAthou];
}

#pragma mark - 定位验证
-(void)setUpLocationAthou{
    // 从偏好设置中读取上一次使用该软件的位置
    NSString *lastAddress = [[NSUserDefaults standardUserDefaults] valueForKey:@"last_address"];
    if (lastAddress != nil) {
        self.title = lastAddress;
    } else {
        self.title = @"南通市";
        [[NSUserDefaults standardUserDefaults] setValue:@"南通市" forKey:@"last_address"];
    }

    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务未打开，请打开定位服务");
        return;
    }
    // 判断是否授权，如果未授权，申请授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 未授权，则申请
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
            // 配置CLLocationManager
            // 配置精度
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            // 配置位置更新的距离
            self.locationManager.distanceFilter = 5;
            // 配置代理
            self.locationManager.delegate = self;
            
            // 开始定位
            [self.locationManager startUpdatingLocation];
        //  [self.locationManager startUpdatingHeading];
        }
    
}
/**
 *  根据地址位置信息设置
 *
 *  @param location 地理位置信息
 */
-(void)setAddressByLocation:(CLLocation *)location{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        NSString *address = placemark.locality;
        NSLog(@"address : %@", address);
        
        // 判断是否需要更新位置信息
        NSString *lastAddress = [[NSUserDefaults standardUserDefaults] valueForKey:@"last_address"];
        if (![address isEqualToString:lastAddress]) {
            // 弹出一个对话框提示是否更改
            NSString *msg = [NSString stringWithFormat:@"您的位置变化到%@，是否切换?", address];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"切换位置" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            // 添加alert action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:cancelAction];
            
            UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 更新控制器标题
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.title = address;
                });
                
                // 将当前的位置写入到偏好设置中
                [[NSUserDefaults standardUserDefaults] setValue:address forKey:@"last_address"];
            }];
            [alertController addAction:submitAction];
            
            // 显示
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
}
- (IBAction)pushCitysListClicked:(UIBarButtonItem *)sender {
   
    
    YSCitysTableViewController *cityListVC = [[YSCitysTableViewController alloc]init];
    // block反向传值的要求2：接收值方实现block对象
    cityListVC.block = ^(NSString *str) {
        // 改变标题地点
        NSString *msg = [NSString stringWithFormat:@"您的位置变化到%@，是否切换?", str];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"切换位置" message:msg preferredStyle:UIAlertControllerStyleAlert];
            
            // 添加alert action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:cancelAction];
            
            UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 更新控制器标题
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.title = str;
                    [self getCoordinateByAddress:str];

                });
                
                // 将当前的位置写入到偏好设置中
                [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"last_address"];
            }];
            [alertController addAction:submitAction];
            
            // 显示
            [self presentViewController:alertController animated:YES completion:nil];
        
    };

    
    [self.navigationController pushViewController:cityListVC animated:YES];
    
}

#pragma mark - private method Coordinate & Address
- (void)getCoordinateByAddress:(NSString *)address {
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // placemarks数组中包含的解析出来的地理位置信息
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocation *location = placemark.location;
        
        NSLog(@"latitude：%f,longitude： %f", location.coordinate.latitude, location.coordinate.longitude);
        //显示UI，根据地点查经纬度
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationLabel.text = [NSString stringWithFormat:@"%.2f, %.2f", location.coordinate.latitude, location.coordinate.longitude];
        });
    }];
}

- (void)getAddressByCoordinate:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // placemarks数组中包含的解析出来的地理位置信息
        CLPlacemark *placemark = [placemarks firstObject];
        
        NSLog(@"地址信息:%@", placemark.addressDictionary);
        NSLog(@"地名:%@", placemark.name);
        // 详细地址信息字典,包含以下部分信息
        // NSString *name=placemark.name;//地名
        // NSString *thoroughfare=placemark.thoroughfare;//街道
        // NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        // NSString *locality=placemark.locality; // 城市
        // NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        // NSString *administrativeArea=placemark.administrativeArea; // 州
        // NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        // NSString *postalCode=placemark.postalCode; //邮编
        // NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        // NSString *country=placemark.country; //国家
        // NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        // NSString *ocean=placemark.ocean; // 海洋
        // NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
    }];
}

#pragma mark location manager delegate
/**
 *  当定位位置信息发生更新操作时，调用该方法
 *
 *  @param manager
 *  @param locations 更新的地理位置信息
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"didUpdateLocations");
    // 获取新的位置信息
    CLLocation *location = [locations firstObject];
    NSLog(@"locations:%@",locations);
    NSLog(@"维度 : %f, 经度: %f", location.coordinate.latitude, location.coordinate.longitude);
    [self setAddressByLocation:location];
//    [self.locationManager stopUpdatingLocation];
    
    // 更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        self.locationLabel.text = [NSString stringWithFormat:@"%.2f, %.2f", location.coordinate.latitude, location.coordinate.longitude];
    });
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"didUpdateHeading");
    

}


@end
