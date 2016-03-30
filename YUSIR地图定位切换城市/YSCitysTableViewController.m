//
//  YSCitysTableViewController.m
//  YUSIR地图定位切换城市
//
//  Created by sq-ios40 on 16/3/25.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSCitysTableViewController.h"
#import "YSCitysTableViewCell.h"
#import "YSHOMEViewController.h"
@interface YSCitysTableViewController ()

@end

@implementation YSCitysTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"Provineces" ofType:@"plist"];
    self.citiesData = [NSArray arrayWithContentsOfFile:dataFilePath];
    
    NSLog(@"city data : %@", self.citiesData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.citiesData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionData = self.citiesData[section];
    NSArray *cities = sectionData[@"cities"];
    return cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"YuCell";
    [tableView registerNib:[UINib nibWithNibName:@"YSCitysTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseIdentifier];
    
    YSCitysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *sectionData = self.citiesData[indexPath.section];
    NSArray *cities = sectionData[@"cities"];
    cell.citiesNameLabel.text = cities[indexPath.row][@"CityName"];
    
    return cell;
}
//设置tableviewcell的section header、、、、、、、、、、
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)] ;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16, 6,tableView.frame.size.width, 30);
//    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:30.f];
    
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    
    [headerView setBackgroundColor:[UIColor grayColor]];
    
    [headerView addSubview:label];
    
    return headerView;
    ////////////////////////////////////////////
//    UIView *viewHeader = [UIView.alloc initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
//    UILabel *lblTitle =[UILabel.alloc initWithFrame:CGRectMake(6, 3, 136, 30)];
//    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:22]];//Font style
//    [lblTitle setTextColor:[UIColor orangeColor]];
//    [lblTitle setTextAlignment:NSTextAlignmentLeft];
//    [lblTitle setTintColor:[UIColor grayColor]];//Background
//    [viewHeader addSubview:lblTitle];
//    viewHeader.backgroundColor = [UIColor grayColor];
//    lblTitle.text =[self tableView:tableView titleForHeaderInSection:section];
//    
//    return viewHeader;
////////////////////////////////////////////////////////////////////////
//    static NSString *header = @"customHeader";
//    UITableViewHeaderFooterView *vHeader ;
//    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
//    if (!vHeader) {
//        vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
//        [vHeader.textLabel setTextColor:[UIColor orangeColor]];
//        [vHeader.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];//Font style
//        vHeader.contentView.backgroundColor = [UIColor grayColor];
//    }
//    vHeader.textLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//    
//    return vHeader;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSDictionary *sectionData = self.citiesData[section];

    return sectionData[@"ProvinceName"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 选中某一个cell,返回上一页
    NSDictionary *sectionData = self.citiesData[indexPath.section];
    NSArray *sectionCities = sectionData[@"cities"];
    
    NSString *selectedCity = sectionCities[indexPath.row][@"CityName"];
    NSLog(@"you have selected %@", selectedCity);
    
//    选择后回到根视图，改变地点
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    // 反向传值
    self.block(selectedCity);
    
    // 反向传值，返回上一级界面
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
