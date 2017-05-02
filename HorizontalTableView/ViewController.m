//
//  ViewController.m
//  HorizontalTableView
//
//  Created by hydom on 2017/3/17.
//  Copyright © 2017年 Liu. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tableDataArray;
@property (strong, nonatomic) NSArray *textArray;
@end
static NSString *MyCellID = @"thisIsMyCellId";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableDataArray = @[[UIColor redColor], [UIColor yellowColor], [UIColor blueColor],[UIColor redColor], [UIColor yellowColor], [UIColor blueColor],[UIColor redColor], [UIColor yellowColor], [UIColor blueColor],[UIColor whiteColor]];
    self.textArray = @[@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"0"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(115, [UIScreen mainScreen].bounds.size.height-400, 150, [UIScreen mainScreen].bounds.size.width) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ScrollViewTableViewCell" bundle:nil] forCellReuseIdentifier:MyCellID];
    [self.view addSubview:self.tableView];

    NSLog(@"%@",self.tableView);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScrollViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyCellID forIndexPath:indexPath];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UIColor *color = [self.tableDataArray objectAtIndex: indexPath.row];
//    [cell.contentView setBackgroundColor: color];
    return cell;
}
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translation = scrollView.contentOffset;
    int a = translation.y/150;
    if (translation.y == 150) {
        scrollView.bounces = YES;
    }
    NSLog(@"滚动到了第%d张",a);

}
//减少自动滚动的距离
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [UIView animateWithDuration:1 animations:^{
        targetContentOffset->x = (targetContentOffset->x - scrollView.contentOffset.x) / 6 + scrollView.contentOffset.x;
        targetContentOffset->y = (targetContentOffset->y - scrollView.contentOffset.y) / 6 + scrollView.contentOffset.y;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中第 %ld",indexPath.row);
}


@end
