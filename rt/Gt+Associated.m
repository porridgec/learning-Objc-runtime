//
//  Gt+Associated.m
//  rt
//
//  Created by Hahn.Chan on 3/3/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import "Gt+Associated.h"
#import <objc/runtime.h>

@implementation Gt (Associated)

- (NSInteger)height {
    return [objc_getAssociatedObject(self, @selector(height)) integerValue];
}

- (void)setHeight:(NSInteger )height {
    objc_setAssociatedObject(self, @selector(height), @(height), OBJC_ASSOCIATION_ASSIGN);
}

- (CodingCallback)callback {
    return objc_getAssociatedObject(self, @selector(callback));
}

- (void)setCallback:(CodingCallback)callback {
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
