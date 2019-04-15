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

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 问题出现
        [LGRuntimeTool lg_betterMethodSwizzlingWithClass:self oriSEL:@selector(helloword) swizzledSEL:@selector(lg_studentInstanceMethod)];
        
        // 解决办法
//        [LGRuntimeTool lg_bestMethodSwizzlingWithClass:self oriSEL:@selector(helloword) swizzledSEL:@selector(lg_studentInstanceMethod)];

    });
}
// 交换之前 :
// lg_studentInstanceMethod(SEL) --> lg_studentInstanceMethod(IMP)
// helloword(SEL) -->nil

// 交换过程：
// helloword(SEL) --> class_addMethod --> --> lg_studentInstanceMethod(IMP)

// helloword(SEL) --> lg_studentInstanceMethod(IMP)
// lg_studentInstanceMethod(SEL) --/--> helloword(IMP)
// 交换不成功，helloword 没有实现，导致交换不成功而使 lg_studentInstanceMethod 找回了自己的 IMP
// 设置空IMP： lg_studentInstanceMethod(SEL) --> 空IMP --> 停止递归
- (void)lg_studentInstanceMethod{
    NSLog(@"LGStudent分类添加的lg对象方法:%s",__func__);
    [self lg_studentInstanceMethod];
}
@end
