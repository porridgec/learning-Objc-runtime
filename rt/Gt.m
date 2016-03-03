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

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"transformToBlueCat"]) {
        class_addMethod([self class], sel, (IMP)transformNow, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void transformNow(id self,SEL cmd) {
    NSLog(@"%@变成了超威蓝猫！",((Gt*)self).name);
}

#pragma mark - NSCoding

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

#pragma mark - Dict

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        for (NSString *key in dictionary.allKeys) {
            id value = dictionary[key];
            
            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                ((void(*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }
    return self;
}

- (NSDictionary *)convertToDictionary {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    if (count != 0) {
        NSMutableDictionary *resultDict = [@{} mutableCopy];
        
        for (NSUInteger i = 0; i < count; i ++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            
            SEL getter = [self propertyGetterByKey:name];
            if (getter) {
                id value = ((id(*)(id, SEL))objc_msgSend)(self, getter);
                resultDict[name] = value ? : @"cannot assgin nil";
            }
        }
        free(properties);
        return resultDict;
    }
    free(properties);
    return nil;
}


- (SEL)propertySetterByKey:(NSString *)key {
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
    
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

- (SEL)propertyGetterByKey:(NSString *)key {
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}

#pragma mark - basic runtime

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
