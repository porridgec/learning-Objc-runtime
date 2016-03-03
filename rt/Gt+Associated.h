//
//  Gt+Associated.h
//  rt
//
//  Created by Hahn.Chan on 3/3/16.
//  Copyright © 2016 Hahn Chan. All rights reserved.
//

#import "Gt.h"

typedef void (^CodingCallback)();

@interface Gt (Associated)

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) CodingCallback callback;

@end
