//
//  ViewController.m
//  单列讲解
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "ViewController.h"
#import "person.h"
#import "XYHttpManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self aboutSharedInstance];

}
-(void)postRequest
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"https://www.jianshu.com"];
    NSMutableURLRequest * requset = [NSMutableURLRequest requestWithURL:url];
    requset.HTTPMethod = @"POST";
    //    requset.HTTPBody
    NSURLSessionDataTask * task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data数据%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"json数据%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    [task resume];
    
}
-(void)getRequest
{
    //创建请求对象
    NSURLSession * session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"https://blog.csdn.net/quanqinyang/article/details/52563661"];
    //创建任务
    NSURLSessionDataTask * task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"解析json数据%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
        
    }];
    // 执行任务
    [task resume];
}
// 以数据流形式上传
-(void)uploadTask
{
    // 1.创建url
    NSString *urlString = @"http://www.xxxx.com/upload.php";
    // urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    // 3.开始上传   request的body data将被忽略，而由fromData提供
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:[NSData dataWithContentsOfFile:@"/Users/yeyifeng/Desktop/技术框架/图片/5.png"]     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
    
}
-(void)downloadTask
{
    // 1.创建url
    NSString *urlString = [NSString stringWithFormat:@"http://www.xxx.com/test.mp3"];
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3.创建会话，采用苹果提供全局的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.创建任务
    NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下!
            // 只会临时保存，因此需要将其另存
            NSLog(@"location:%@",location.path);
            
            // 采用模拟器测试，为了方便将其下载到Mac桌面
            //            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *filePath = @"/Users/yeyifeng/Desktop/test.mp3";
            NSError *fileError;
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError];
            if (fileError == nil) {
                NSLog(@"file save success");
            } else {
                NSLog(@"file save error: %@",fileError);
            }
        } else {
            NSLog(@"download error:%@",error);
        }
    }];
    
    // 5.开启任务
    [downloadTask resume];
}

#pragma mark - 介绍了关于单列类的使用场景和方法
-(void)aboutSharedInstance
{
    
    person * p1 = [[person alloc]init];
    person * p2 = [[person alloc]init];
    person * p3 = [[person alloc]init];
    NSLog(@"%@ \n %@ \n %@",p1,p2,p3);
    
    /*
     <person: 0x60000001fa90>
     <person: 0x60000001fb60>
     <person: 0x60000001fb50>
     
     */
    person * p4 = [person sharedInstance];
    person * p5 = [person sharedInstance];
    person * p6 = [person sharedInstance];
    NSLog(@"%@ \n %@ \n %@",p4,p5,p6);
    /*
     <person: 0x60c00000cc00>
     <person: 0x60c00000cc00>
     <person: 0x60c00000cc00>
     */
    //    用sharedInstance每次返回的是同一个实例，但是用alloc init每次会返回新的实例。
    
    //    重写allocWithZone：之后 执行如下
    /*
     <person: 0x608000008790>
     <person: 0x608000008790>
     <person: 0x608000008790>
     <person: 0x608000008790>
     <person: 0x608000008790>
     <person: 0x608000008790>
     */
    //返回来了同一个实例，不管用alloc init创建还是直接用sharedInstance这个方法
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
