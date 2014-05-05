//
//  DataFormViewController.h
//  比特币监控神器
//
//  Created by ios_Dream on 14-3-5.
//  Copyright (c) 2014年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "Coin.h"
#import "MonitorViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@class MonitorViewController;
@interface DataFormViewController : UIViewController<ASIHTTPRequestDelegate>

@property (nonatomic, strong)NSMutableData *coinData;
@property (nonatomic, strong)Coin *coin;
//@property (nonatomic, strong)Data *coinData;

@property (nonatomic, strong)NSDictionary * headerFields;

@property (nonatomic, strong)NSString * coinString;
@property (strong, nonatomic) MonitorViewController * monitorViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;
//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;
//重新加载表视图
-(void)reloadView:(NSDictionary*)res;
//开始请求Web Service
-(void)startRequest;


-(NSURL *)URLWithCoinName:(NSString *)coinName andPlatFormName:(NSString *) platFormName;

-(NSString *)coinStringWithURL:(NSURL *)url;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UILabel *highPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *VolPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sellPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastPriceLabel;

@property (strong, nonatomic) NSString * highlabel;
@end
