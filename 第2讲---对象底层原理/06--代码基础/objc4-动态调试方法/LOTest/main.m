//
//  main.m
//  LOTest
//
//  Created by Lucas on 2019/2/18.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "LGPerson.h"

void test1(){
    // imp 获取 why
    IMP imp1 = class_getMethodImplementation([LGPerson class], @selector(lg_instanceMethod));
    IMP imp2 = class_getMethodImplementation([LGPerson class], @selector(lg_classMethod));
    IMP imp3 = class_getMethodImplementation(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod));
    IMP imp4 = class_getMethodImplementation(objc_getMetaClass("LGPerson"), @selector(lg_classMethod));
    NSLog(@"%p-%p-%p-%p",imp1,imp2,imp3,imp4);
    // objc_msgSend
    // objc_msgForward
    // 全部都可以拿到，因为有 消息转发机制
    NSLog(@"ok");
}

void test2(){
    // 实例方法获取 -- 对象实例方法 -- 在类里
    // 类方法 -- 元类
    Method method1 = class_getInstanceMethod([LGPerson class], @selector(lg_instanceMethod)); // 类对象 拿 实例方法  YES
    Method method2 = class_getInstanceMethod(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod)); // 元类对象 拿 实例方法 NO
    
    Method method3 = class_getInstanceMethod([LGPerson class], @selector(lg_classMethod));  // 类对象 拿 类方法    NO
    Method method4 = class_getInstanceMethod(objc_getMetaClass("LGPerson"), @selector(lg_classMethod)); // 元类对象 拿 类方法   YES
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    // 1:1 2:1 3:1 4:1
    NSLog(@"ok");
}

void test3(){
    // 类方法获取
    Method method1 = class_getClassMethod([LGPerson class], @selector(lg_instanceMethod));  // 类对象 拿 实例方法  NO
    Method method2 = class_getClassMethod(objc_getMetaClass("LGPerson"), @selector(lg_instanceMethod)); // 元类对象 拿 实例方法 NO
    
    // 类 --> lg_classMethod 类方法
    // 元类
    Method method3 = class_getClassMethod([LGPerson class], @selector(lg_classMethod));         // 类对象 拿 类方法   YES
    Method method4 = class_getClassMethod(objc_getMetaClass("LGPerson"), @selector(lg_classMethod));    // 元类对象 拿 类方法  YES
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"ok");
}

int main(int argc, const char * argv[]) {
    test2();
    NSLog(@"end");
    return 0;
}

