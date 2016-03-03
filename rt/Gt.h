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
    NSString *_role;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end
