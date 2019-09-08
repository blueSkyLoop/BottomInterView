//
//  ViewController.m
//  01---实例对象-类对象-元类之间的关系
//
//  Created by cooci on 2019/2/8.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "LGPerson.h"
#import "LGMan.h"
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // po p->isa (实例对象的isa 就是 LGMan 这个类对象)
    // po p  获取实例对象的内存地址
    // x + "内存地址" -> 获取分段地址位置，得出 isa指针的内存地址
    // 优化过的 &0x00007ffffffffff8 例: p/x 0x01034fa160 & 0x00007ffffffffff8
    LGMan *p = [[LGMan alloc] init];
    p.name      = @"Cooci";
    p.age       = 18;
    
    Class class1= [LGMan class];
    Class class2= p.class;
    Class class3= object_getClass(p);
    NSLog(@"\n%p-\n%p-\n%p",class1,class2,class3);
    NSLog(@"\n%@-\n%@-\n%@",class1,class2,class3); // 都是 LGPerson
    Class class4= object_getClass(class3);
    NSLog(@"\n%p\n%@",class4,class4);
    NSLog(@"end");
//    [self lgPrintClassRelationshipWithObject:p];
}

- (void)lgPrintClassRelationshipWithObject:(id)objc{
    NSLog(@"*********************************************");
    NSLog(@"\n实例对象地址 - %p - %@",objc,objc); // 实例对象 LGMan
    NSLog(@"\n类对象地址 - %p - %@",[objc class],[objc class]); // 类对象 LGMan
    NSLog(@"\n父类对象地址 - %p - %@",[objc superclass],[objc superclass]); // 父类 LGPerson
    NSLog(@"\n元类对象地址 - %p - %@",object_getClass(objc),object_getClass(objc)); // 元类对象 LGMan
    NSLog(@"\n元类的父类对象地址 - %p - %@",[object_getClass(objc) superclass],[object_getClass(objc) superclass]); // 元类的父类 LGPerson
    NSLog(@"\n根元类对象地址 - %p - %@",object_getClass(object_getClass(objc)),object_getClass(object_getClass(objc))); // 根元类 NSObject 错了 是 LGMan
    NSLog(@"\n根元类的父类对象地址 - %p - %@",[object_getClass(object_getClass(objc)) superclass],[object_getClass(object_getClass(objc)) superclass]);    // 根元类的父类对象 NSObject 错了 是 LGPerson
    NSLog(@"\n根根元类对象地址 - %p - %@",object_getClass(object_getClass(object_getClass(objc))),object_getClass(object_getClass(object_getClass(objc)))); //根根元类对象 NSObject
    NSLog(@"\n根根元类的父类对象地址 - %p - %@",[object_getClass(object_getClass(object_getClass(objc))) superclass],[object_getClass(object_getClass(object_getClass(objc))) superclass]); // 根根元类的父类 NSObject
    NSLog(@"*********************************************");
}


@end
