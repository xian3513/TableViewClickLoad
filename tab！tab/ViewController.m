//
//  ViewController.m
//  tab！tab
//
//  Created by kt on 15/2/17.
//  Copyright (c) 2015年 kt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation ViewController {
    NSMutableArray *dataArray;
    NSInteger height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData {
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i=0;i<10;i++) {
        dataArray[i] = [NSString stringWithFormat:@"第%d个",i];
    }
    height = 40;
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height/3) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    tab.bounces = NO;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
static NSString *identifier = @"cell";
    identifier = @"dd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell.textLabel.textAlignment == NSTextAlignmentCenter) {
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == dataArray.count) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"点击加载...";
        return cell;
    }
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row%10 == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = @"加载中...";
        [self loadDataClickedRowFinished:^{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [tableView reloadData];
        }];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == dataArray.count-2) {
        [self loadDataClickedRowFinished:^{
          [tableView reloadData];
        }];
    }
}

- (void)loadDataClickedRowFinished:(void(^)())finish{
        [self factoryWithData];
        finish();
}
- (void)factoryWithData {
    NSInteger count = dataArray.count;
    for(NSInteger i=count;i<count+10;i++) {
        dataArray[i] = [NSString stringWithFormat:@"第%ld个",i];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
