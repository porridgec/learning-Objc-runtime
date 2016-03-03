//
//  Gt.h
//  rt
//
//  Created by Hahn.Chan on 3/3/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gt : NSObject <NSCoding>
{
    NSString *_locality;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *role;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)convertToDictionary;

- (void)transformToBlueCat;

@end
