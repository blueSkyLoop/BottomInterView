//
//  LGPerson.h
//  003---字节对齐
//
//  Created by cooci on 2019/2/15.
//  Copyright © 2019 cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject
// isa --- 8bit
@property (nonatomic, assign) int age; // 4bit
@property (nonatomic, copy) NSString *name; // 8bit
@property (nonatomic, assign) int height; // 4bit

@end

NS_ASSUME_NONNULL_END
