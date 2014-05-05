//
//  DataFormViewController.m
//  比特币监控神器
//
//  Created by ios_Dream on 14-3-5.
//  Copyright (c) 2014年 ZY. All rights reserved.
//

#import "DataFormViewController.h"

@interface DataFormViewController ()
@property (nonatomic,strong) NSString * dataString;
@end

@implementation DataFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    
	[self startRequest];
	
	
}
-(void)startRequest{
    [self httpGetSynchronousRequest];
//	[self httpGetAsynchronousRequest];
	
	//[self httpPostSynchronousRequest];
//    [self httpPostAsynchronousRequest];
    
}


//同步GET请求
-(void)httpGetSynchronousRequest
{
    NSURL *url = [NSURL URLWithString:	@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"];
    
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url] ;
	//设置超时时间
	request.timeOutSeconds = 20;
	request.delegate = self;
	
	//发起一个同步请求  如果不手动发起请求，不会默认发起
	[request startSynchronous];
	
	
}
//同步POST请求
-(void)httpPostSynchronousRequest
{
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8080/B/b"]];
	request.timeOutSeconds = 20;
	request.delegate = self;
	
	[request addPostValue:@"admin123" forKey:@"user"];
	[request addPostValue:@"user@qq.com" forKey:@"email"];
    
	[request startSynchronous];
	
}
//异步GTE请求
-(void)httpGetAsynchronousRequest
{
//	NSString *urlStr = [NSURL URLWithString:@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"];
//	NSURL *url = [NSURL URLWithString:urlStr];
    NSURL *url = [NSURL URLWithString:	@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"];

	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	//设置超时时间
	request.timeOutSeconds = 20;
	request.delegate = self;
	
	//发起一个异步请求  如果不手动发起请求，不会默认发起
	[request startAsynchronous];
}

//异步POST请求
-(void)httpPostAsynchronousRequest
{
    //	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://125.0.0.176/greenload/test_wifi"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"]];
	request.timeOutSeconds = 20;
	request.delegate = self;
	
	[request addPostValue:@"admin123" forKey:@"user_id"];
	[request addPostValue:@"user@qq.com" forKey:@"email"];
	
	[request startAsynchronous];
}


-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
	NSLog(@"%@", responseHeaders);
}

//说明：这个协议方法不要重写，ASI框架利用这个方法帮我们处理了数据，只需要在请求结束的时候获得数据即可
//如果重写这个方法需要你自己处理数据
//-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
//{
//}

-(void)requestFinished:(ASIHTTPRequest *)request
{
	//[request responseString] 以字符串的形式展示返回的数据，如果返回的数据不是字符串，得到的结果会有问题，有的时候字符串存在编码问题，得到字符串可能是乱码，需要自己首先获得data然后用data创建字符串并指定编码方式为utf-8
	
	//[request responseData]   以二进制数据的形式展示返回的数据
	
	NSLog(@"这里是返回结果--->%@", [request responseString]);

    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[request responseData]
                                                         options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"dict11:%@",dict);
    self.highPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"HignPrice"]];
    self.buyPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"BuyPrice"]];
    self.lastPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"LastPrice"]];
    self.lowPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"LowPrice"]];
    self.sellPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"SellPrice"]];
    self.VolPriceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Vol"]];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
	NSLog(@"请求失败！");
}

//**************************************//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    
//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"];
//    _dataString = [self coinStringWithURL:url];
////    self.highPriceLabel.text = @"1231312111111";
//    NSLog(@"_dataString:%@",_dataString);
//    
//    
//    NSNotificationCenter * notificationCenter =
//    [NSNotificationCenter defaultCenter];
//    
//    [notificationCenter addObserver:self
//                           selector:@selector(receiveData:)
//                               name:@"coinData"
//                             object:nil];
//    
//    // Do any additional setup after loading the view from its nib.
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
////    NSURL *url = [NSURL URLWithString:@"http://192.168.1.106:8181/api/CoinAPI?cid=0&pid=0"];
////    _dataString = [self coinStringWithURL:url];
////    
////    NSLog(@"_dataString:%@",_dataString);
////    
//    
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)startRequest{
//    
//}
//-(NSURL *)URLWithCoinName:(NSString *)coinName andPlatFormName:(NSString *)platFormName{
//    ///////////////////
//    
//    NSURL * url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
//    return url;
//}
//-(NSString *)coinStringWithURL:(NSURL *)url{
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    //异步请求
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    if (connection) {
//        NSLog(@"链接成功");
//    }
//    
//    return self.coinString;
//}
//-(void)reloadView:(NSDictionary *)res{
//    
//}
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
//    self.headerFields = res.allHeaderFields;
//    NSLog(@"res.allHeaderFields:%@",self.headerFields);
//    self.coinData = [NSMutableData data];
//    
//    self.coin = [[Coin alloc] init];
//    NSString * nowTime = [_headerFields objectForKey:@"Date"];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz"];
//    
//    //    NSDate *now = [NSDate date];
//    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
//    //    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
//    
//    //    if(components.hour > 12){
//    //
//    //    }
//    
//    _coin.nowTime = [formatter dateFromString:nowTime];
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: _coin.nowTime];
//    NSDate *localeDate = [_coin.nowTime  dateByAddingTimeInterval: interval];
//    NSLog(@"enddate=%@",localeDate);
//    NSLog(@"_coin.nowTime:%@",_coin.nowTime);
//}
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    NSLog(@"data.length:%d",data.length);
//    [self.coinData appendData:data];
//}
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    NSLog(@"connectionDidFinishLoading");
//    NSLog(@"self.coinData:%@",self.coinData);
//    NSLog(@"请求完成…");
//    
//    _coinString = [[NSString alloc]initWithData:self.coinData encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonString:%@",_coinString);
//    
//    
//    
//    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:_coinData
//                                                         options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"dict11:%@",dict);
//    
//    [self coinWithDictionary:dict];
//    NSLog(@"_coin.nowTime:%@",_coin.nowTime);
//    
//    //    [self coinWithDictionary:dict];
//    //    [self reloadView:dict];
//    
//    
//    
////    [self.coinData writeToFile:@"/Users/apple/Desktop/recivefile/a.txt" atomically:NO];
//}
//-(Coin *)coinWithDictionary:(NSDictionary *) dictionary{
//    NSString * buyPrice = [dictionary objectForKey:@"BuyPrice"];
//    NSString * hignPrice = [dictionary objectForKey:@"HignPrice"];
//
////    self.highPriceLabel.text=[dictionary objectForKey:@"HignPrice"];
//    NSString * lastPrice = [dictionary objectForKey:@"LastPrice"];
//    NSString * lowPrice = [dictionary objectForKey:@"LowPrice"];
//    NSString * sellPrice = [dictionary objectForKey:@"SellPrice"];
//    NSString * vol = [dictionary objectForKey:@"Vol"];
//    NSLog(@"hignPrice:%@",hignPrice);
//    
//    NSNotificationCenter * notificationCenter =
//    [NSNotificationCenter defaultCenter];
//    NSNotification * notification =
//    [NSNotification notificationWithName:@"coinData"
//                                  object:nil
//                                userInfo:dictionary];
//    [notificationCenter postNotification:notification];
//    
//    
////    NSString *hp = @"33";
////    self.highPriceLabel.text =(NSString *) hignPrice;
////    _coin.buyPrice = [buyPrice floatValue];
////    _coin.highPrice = [hignPrice floatValue];
////    _coin.lastPrice = [lastPrice floatValue];
////    _coin.lowPrice = [lowPrice floatValue];
////    _coin.sellPrice = [sellPrice floatValue];
////    _coin.vol = [vol doubleValue];
////    
////    NSLog(@"buyPrice:%f",_coin.buyPrice);
////    NSLog(@"HignPrice:%f",_coin.highPrice);
////    NSLog(@"LastPrice:%f",_coin.lastPrice);
////    NSLog(@"LowPrice:%f",_coin.lowPrice);
////    NSLog(@"SellPrice:%f",_coin.sellPrice);
////    NSLog(@"Vol:%f",_coin.vol);
////    
////    NSLog(@"_coin:%@",_coin.nowTime);
//    
//    
//    return self.coin;
//}
//
///*
// 2014-03-05 22:40:00.115 比特币监控神器[7086:a0b] res.allHeaderFields:{
// "Cache-Control" = "no-cache";
// "Content-Length" = 145;
// "Content-Type" = "application/json";
// Date = "Wed, 05 Mar 2014 14:40:01 GMT";
// Expires = "-1";
// Pragma = "no-cache";
// Server = "Microsoft-IIS/7.5";
// "X-AspNet-Version" = "4.0.30319";
// "X-Powered-By" = "ASP.NET";
// }
// 
// 2014-03-05 21:27:41.777 比特币监控神器[6821:a0b] jsonString:{
// "BuyPrice": 3959.99,
// "SellPrice": 3960.0,
// "HignPrice": 4260.0,
// "LowPrice": 3845.0,
// "LastPrice": 3960.0,
// "Vol": 291007.3373
// }
// 2014-03-05 21:27:45.605 比特币监控神器[6821:a0b] dict11:{
// BuyPrice = "3959.99";
// HignPrice = 4260;
// LastPrice = 3960;
// LowPrice = 3845;
// SellPrice = 3960;
// Vol = "291007.3373";
// }
// */
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"error:%@",[error localizedDescription]);
//}
//- (void)receiveData:(id)sender
//{
//    NSNotification * notification = sender;
//    NSLog(@"这次的新品: %@", notification.userInfo);
//    NSString * buyPrice = [notification.userInfo objectForKey:@"BuyPrice"];
//    NSString * hignPrice = [notification.userInfo objectForKey:@"HignPrice"];
//    NSString * lastPrice = [notification.userInfo objectForKey:@"LastPrice"];
//    NSString * lowPrice = [notification.userInfo objectForKey:@"LowPrice"];
//    NSString * sellPrice = [notification.userInfo objectForKey:@"SellPrice"];
//    NSString * vol = [notification.userInfo objectForKey:@"Vol"];
//    
//    self.highlabel = hignPrice;
//        NSLog(@"这 self.highlabel的新品: %@", self.highlabel);
//    [self performSelectorOnMainThread:@selector(receivedData:)
//                           withObject:hignPrice
//                        waitUntilDone:NO];
//
////    self.highPriceLabel.text = hignPrice;
////    self.lowPriceLabel.text = lowPrice;
////    self.VolPriceLabel.text = vol;
////    self.buyPriceLabel.text = buyPrice;
////    self.lastPriceLabel.text = lastPrice;
////    self.sellPriceLabel.text = sellPrice;
////    NSLog(@"这highPriceLabel的新品: %@", _highPriceLabel.text);
//
//}
//- (void)receivedData:(id)sender{
//            NSLog(@"self.highlabel: %@", sender);
////    self.highPriceLabel.text = sender;
//}
//
//
//- (void)dealloc
//{
//    NSNotificationCenter * notificationCenter =
//    [NSNotificationCenter defaultCenter];
//    
//    [notificationCenter removeObserver:self name:@"coinData" object:nil];
//}
@end
