//
//  LiveTableViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/27.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "LiveTableViewController.h"
#import "LivePlayerViewController.h"
#import "WFLiveCell.h"
#import "WFLiveItem.h"

@interface LiveTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataArr;
@property(nonatomic,strong)UITableView * liveTableView;

@end

@implementation LiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.title = @"直播列表";
//        [self setup];
     self.liveTableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview: self.liveTableView ];
     self.liveTableView .delegate = self;
     self.liveTableView .dataSource = self;
    [self.liveTableView registerNib:[UINib nibWithNibName:@"WFLiveCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
//    self.liveTableView = liveTableView;
    [self loadData];
    [self setup];
    
    
    // Do any additional setup after loading the view.
}
- (void)setup
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
   // [self setupTopMenu];
}
-(void)rankCrown{
    
}
-(void)loadData{
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.dataArr = [NSArray yy_modelArrayWithClass:NSClassFromString(@"WFLiveItem") json:responseObject[@"lives"]];
        [self.liveTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
#pragma mark - tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WFLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.liveModel = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LivePlayerViewController * liveVC = [[LivePlayerViewController alloc]init];
    liveVC.liveModel = self.dataArr[indexPath.row];
    [self.navigationController presentViewController:liveVC animated:YES completion:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
