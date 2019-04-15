//
//  LGStudent+LG.m
//  006---Method-Swizzling坑
//
//  Created by cooci on 2019/2/16.
//  Copyright © 2019 cooci. All rights reserved.
//

#import "LGStudent+LG.h"
#import "LGRuntimeTool.h"
#import <objc/runtime.h>

@implementation LGStudent (LG)
// 子类 -- 没有实现父类的方法
// 子类 -- 交换了父类的方法

// 1. 因为 student类没有实现 personInstanceMethod ，调用的时候是调用了父类的方法， 但下列操作把父类的 personInstanceMethod 交换了 ， 但可以正常运行
//   personInstanceMethod(SEL) - lg_studentInstanceMethod(IMP)
//   lg_studentInstanceMethod(SEL) - personInstanceMethod(IMP)

// 2. 因为 personInstanceMethod 已经被交换成 lg_studentInstanceMethod 了，当父类 Person 调用 自己的 personInstanceMethod 的时候会发生崩溃，因为
//    已经被处理为 personInstanceMethod(SEL) - lg_studentInstanceMethod(IMP)， 然而 lg_studentInstanceMethod 却是 student 的类别， 所以作为 Person 类无法查找到此方法而导致崩溃

// 解决办法，1.方法交换时使用一个判断 BOOL didAddMethod = class_addMethod （靠谱）
//         2.子类实现 personInstanceMethod ， 以交互的时候就是针对了 student 的方法进行处理，而不对父类处理
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 子类 student 没有实现 personInstanceMethod
        // 但子类对父类的方法进行了交换，若交换时不加处理会发生崩溃
        [LGRuntimeTool lg_methodSwizzlingWithClass:self oriSEL:@selector(personInstanceMethod) swizzledSEL:@selector(lg_studentInstanceMethod)];
    });
}

- (void)lg_studentInstanceMethod{
    NSLog(@"LGStudent分类添加的lg对象方法:%s",__func__);
    [self lg_studentInstanceMethod];
}
@end
