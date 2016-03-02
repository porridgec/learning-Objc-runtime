//
//  main.m
//  rt
//
//  Created by Hahn.Chan on 3/1/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void sayFunc(id self, SEL _cmd, id some) {
    NSLog(@"他说,我叫%@,今年%@岁了,%@！",[self valueForKey:@"name"],[self valueForKey:@"age"],some);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Class Gt = objc_allocateClassPair([NSObject class], "Gt", 0);
        class_addIvar(Gt, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
        class_addIvar(Gt, "_age", sizeof(NSInteger), sizeof(NSInteger), @encode(NSInteger));
        
        SEL s = sel_registerName("say");
        class_addMethod(Gt, s, (IMP)sayFunc, "v@:@");
        
        objc_registerClassPair(Gt);
        
        id wuke = [[Gt alloc] init];
        //[wuke setValue:@"吴克" forKey:@"name"];
        Ivar nameIvar = class_getInstanceVariable(Gt, "_name");
        object_setIvar(wuke, nameIvar, @"吴克");
        
        [wuke setValue:@5 forKey:@"age"];
//        Ivar ageIvar = class_getInstanceVariable(Gt, "_age");
//        object_setIvar(wuke, ageIvar, @5);
        
        
        ((void(*)(id, SEL, id))objc_msgSend)(wuke, s ,@"我是超威蓝猫！");
        
        wuke = nil;
        
        objc_disposeClassPair(Gt);
        
    }
    return 0;
}
