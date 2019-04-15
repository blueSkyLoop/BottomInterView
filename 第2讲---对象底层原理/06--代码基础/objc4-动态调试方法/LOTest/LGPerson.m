//
//  LGPerson.m
//  LGTest
//
//  Created by cooci on 2019/2/15.
//

#import "LGPerson.h"

@implementation LGPerson
- (void)lg_instanceMethod{
    NSLog(@"我是一个对象方法");
}
+ (void)lg_classMethod{
    NSLog(@"我是一个类方法");
}
@end
