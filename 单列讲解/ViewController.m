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
