//
//  Drop.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Drop.h"

@implementation Drop

- (id)initWithName:(NSString *)name {
    self = (Drop *)[CCBReader load:[NSString stringWithFormat:@"Items/%@",name]];
    if (self) {
        self.fileName = name;
    }
    return self;
}

@end
