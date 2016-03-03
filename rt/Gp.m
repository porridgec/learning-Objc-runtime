//
//  Gp.m
//  rt
//
//  Created by Hahn.Chan on 3/3/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import "Gp.h"
#import "Gt.h"

@implementation Gp

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"act"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation setSelector:@selector(say)];
    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"%@失败",NSStringFromSelector(aSelector));
}

- (void)say {
    NSLog(@"小朋友们，还记得我是谁吗？");
}
@end
