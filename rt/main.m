//
//  main.m
//  rt
//
//  Created by Hahn.Chan on 3/1/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "Gt.h"
#import "Gt+Associated.h"

void sayFunc(id self, SEL _cmd) {
    NSLog(@"他说,我来自%@,我叫%@,今年%@岁了,我是%@,我身高%@cm！",[self valueForKey:@"locality"],[self valueForKey:@"name"],[self valueForKey:@"age"],[self valueForKey:@"role"],[self valueForKey:@"height"]);
}

//2016.03.02
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//
//        //动态注册一个新类
//        Class Gt = objc_allocateClassPair([NSObject class], "Gt", 0);
//        class_addIvar(Gt, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
//        class_addIvar(Gt, "_age", sizeof(NSInteger), sizeof(NSInteger), @encode(NSInteger));
//
//        //注册一个新的方法
//        SEL s = sel_registerName("say");
//        class_addMethod(Gt, s, (IMP)sayFunc, "v@:@");
//        
//        objc_registerClassPair(Gt);
//        
//        id wuke = [[Gt alloc] init];
//        //[wuke setValue:@"吴克" forKey:@"name"];
//        Ivar nameIvar = class_getInstanceVariable(Gt, "_name");
//        object_setIvar(wuke, nameIvar, @"吴克");
//        
//        [wuke setValue:@5 forKey:@"age"];
////        Ivar ageIvar = class_getInstanceVariable(Gt, "_age");
////        object_setIvar(wuke, ageIvar, @5);
//        
//        
//        ((void(*)(id, SEL, id))objc_msgSend)(wuke, s ,@"我是超威蓝猫！");
//        
//        wuke = nil;
//        
//        objc_disposeClassPair(Gt);
//        
//    }
//    return 0;
//}

//2016.03.03
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //
//        Gt *wuke = [[Gt alloc] init];
//        wuke.name = @"吴克";
//        wuke.age = 5;
//        [wuke setValue:@"石家庄" forKey:@"locality"];
//        [wuke setValue:@"超威蓝猫" forKey:@"role"];
//        wuke.height = 20;
//        
//        SEL s = sel_registerName("say:");
//        class_addMethod([Gt class], s, (IMP)sayFunc, "v@:@");
//        
//        ((void(*)(id, SEL))objc_msgSend)(wuke, s);
    
//        NSDictionary *propertyResultDic = [wuke allProperties];
//        for (NSString *propertyName in propertyResultDic.allKeys) {
//            NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyResultDic[propertyName]);
//        }
//
//        NSDictionary *ivarResultDic = [wuke allIvars];
//        for (NSString *ivarName in ivarResultDic.allKeys) {
//            NSLog(@"ivarName:%@, ivarValue:%@",ivarName, ivarResultDic[ivarName]);
//        }
//
//        NSDictionary *methodResultDic = [wuke allMethods];
//        for (NSString *methodName in methodResultDic.allKeys) {
//            NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
//        }
        
//        wuke.callback = ^(){
//            NSLog(@"从人群中钻出一个大光头！");
//        };
//        wuke.callback();
        
//        NSString *path = [NSString stringWithFormat:@"%@/Desktop/Gt",NSHomeDirectory()];
//        //归档
//        [NSKeyedArchiver archiveRootObject:wuke toFile:path];
//        //解档
//        Gt *anotherWuke = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        anotherWuke.height = 20;
//        ((void(*)(id, SEL))objc_msgSend)(anotherWuke, s);
        
        NSDictionary *dict = @{
                               @"name" : @"吴克",
                               @"age" : @18,
                               @"role" : @"超威蓝猫"
                               };
        Gt *wuke = [[Gt alloc] initWithDictionary:dict];
        NSLog(@"他说,我叫%@,今年%@岁了,我是%@", wuke.name, wuke.age, wuke.role);
        
        NSDictionary *newDict = [wuke convertToDictionary];
        NSLog(@"%@",newDict);
    }
    return 0;
}
