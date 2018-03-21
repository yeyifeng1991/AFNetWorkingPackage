//
//  person.m
//  单列讲解
//
//  Created by YeYiFeng on 2018/3/21.
//  Copyright © 2018年 叶子. All rights reserved.
//

#import "person.h"

@implementation person
/*
 //调用顺序 如下
 -(instancetype)init{
 if (self = [super init])// 3
 {
 
 }
 return self;// 4
 }
 +(instancetype)allocWithZone:(struct _NSZone *)zone
 {
 static person *person = nil;
 person = [super allocWithZone:zone];//  1
 return person;// 2
 }
 +(instancetype)sharedInstance;
 {
 static person *single = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 single =[[self alloc]init];
 });
 return single;
 }
 */
+(void)load
{
//    对于加入运行期系统中的每个类（class）及分类（category）来说，都会调用此方法，且只会调用一次。如果分类和其所属的类都调用了load方法，则先调用类里面的，再调用分类里的。
//    load方法并不像普通方法那样，它并不遵从继承规则。即如果某个类本身没有load方法，那么不管其超类是否实现load方法，系统都不会调用。
    NSLog(@"load%@ %s",self,__func__);
}
//initialize方法优于load执行
+ (void)initialize
{
//    对每个类来说，该方法会在程序首次使用该类前调用，且只调用一次。它是由运行期系统来调用的，绝不应该通过代码直接调用。
//    initialize方法与其他消息一样，如果某个类未实现它，而其超类实现了，就会运行超类的实现代码。
    NSLog(@"initialize%@ %s", self, __FUNCTION__);
}

 +(instancetype)sharedInstance
{
    return [[self alloc]init];
}
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static person * single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [super allocWithZone:zone];// 最先执行，只执行一次
    });
    return single;
}
@end
