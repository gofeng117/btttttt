//
//  ASIHttpTestViewController.m
//  ASIHttpTest
//
//  Created by wxg on 13-7-10.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ASIHttpTestViewController.h"

@implementation ASIHttpTestViewController

//同步GET请求
-(void)httpGetSynchronousRequest
{
	NSString *user = @"admin";
	NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/B/b?user=%@", user];
//	NSURL *url = [NSURL URLWithString:urlStr];
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
	NSString *user = @"admin";
	NSString *urlStr = [NSString stringWithFormat:@"http://127.0.0.1:8080/B/b?user=%@", user];
	NSURL *url = [NSURL URLWithString:urlStr];
	
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
	//[request addPostValue:@"user@qq.com" forKey:@"email"];
	
	[request startAsynchronous];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self httpGetSynchronousRequest];
	//[self httpGetAsynchronousRequest];
	
	//[self httpPostSynchronousRequest];
//	[self httpPostAsynchronousRequest];
	
	
	
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
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[request responseData]
                                                         options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"dict11:%@",dict);
    label.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"BuyPrice"]];
    [self.view addSubview:label];

}
-(void)requestFailed:(ASIHTTPRequest *)request
{
	NSLog(@"请求失败！");
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end
