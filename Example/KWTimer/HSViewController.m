//
//  HSViewController.m
//  KWTimer
//
//  Created by devkevinma@gmail.com on 05/27/2017.
//  Copyright (c) 2017 devkevinma@gmail.com. All rights reserved.
//

#import "HSViewController.h"
#import <KWTimer/KWTimer.h>

@interface HSViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, assign) dispatch_queue_t queue;

@property (nonatomic, strong) NSThread *thread;

@end

@implementation HSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"调试选项";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCells];
    [self tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

/** 在这里注册事件 */
- (void)addCells
{
    [self registerCellWithTitle:@"弹窗" action:^(NSInteger index) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"弹窗" message:@"需要自定义弹窗" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }];
    
    [self registerCellWithTitle:@"测试定时器" action:^(NSInteger index) {
//        _queue = dispatch_get_global_queue(0, 0);
//        dispatch_async(_queue, ^{
//            NSLog(@"%@",[NSThread currentThread]);
//            self.thread = [NSThread currentThread];
//            [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
            [self addIntervalAction:@selector(intervalAction) withInterval:0.3];
//        });
    }];
}

- (void)intervalAction
{
    NSLog(@"线程  --->  %@",[NSThread currentThread]);
}

# pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"demoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = self.datas[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    void(^act)(NSInteger idx) = self.datas[indexPath.row][@"action"];
    act(indexPath.row);
}

# pragma mark - private

- (void)registerCellWithTitle:(NSString *)title action:(void(^)(NSInteger index))action
{
    NSString *t = title ?: @"undefine";
    void(^act)(NSInteger index) = action ?: ^(NSInteger index){};
    NSDictionary *dict = @{@"title":t,@"action":act};
    [self.datas addObject:dict];
}

# pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [@[] mutableCopy];
    }
    return _datas;
}

@end
