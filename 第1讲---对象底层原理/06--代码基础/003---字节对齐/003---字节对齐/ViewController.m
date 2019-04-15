//
//  ViewController.m
//  003---字节对齐
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "ViewController.h"
#import "LGPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LGPerson *ac = [LGPerson alloc];
    ac.age  = 18;
    ac.name = @"cooci";
    ac.height = 185;
    NSLog(@"%zu",class_getInstanceSize([ac class])); // 8字节对齐后 --- 再使用16字节对齐
    NSLog(@"%zu",malloc_size((__bridge const void *)(ac))); // 16 系统内存分配对齐
    // 系统 内存对齐 --- ISA（8） age（4） (int 剩 4) name(8)
    // 8  算法
    // 16 优化
    // 对象内存分配 64位的计算方式
    // isa -- age -- height -- name  : 8 + 4 + 4 + 8 = 24 ---- 32
    // isa -- age -- name -- height  : 8 + 8 + 8 + 8 = 32 ---- 32


}



@end
