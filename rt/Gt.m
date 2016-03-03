//
//  Gt.m
//  rt
//
//  Created by Hahn.Chan on 3/3/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import "Gt.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Gt

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (NSUInteger i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSUInteger i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (NSDictionary *)allProperties {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSInteger i = 0; i < count; i ++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        
        resultDict[name] = propertyValue ? : @"cannot assign nil";
    }
    
    free(properties);
    
    return resultDict;
}

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i ++) {
        const char *varName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:varName];
        id varValue = [self valueForKey:name];
        
        resultDict[name] = varValue ? : @"cannot assign nil";
    }
    free(ivars);
    return resultDict;
}

- (NSDictionary *)allMethods {
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    Method *methods = class_copyMethodList([self class], &count);
    
    for (NSInteger i = 0; i < count; i ++) {
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        
        int arguments = method_getNumberOfArguments(methods[i]);
        
        resultDict[name] = @(arguments - 2);
    }
    free(methods);
    return resultDict;
}

@end
