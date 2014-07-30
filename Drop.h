//
//  Drop.h
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Drop : CCNode

@property (assign) int multiplier;
@property (nonatomic,strong) NSString *fileName;

- (id)initWithName:(NSString *)name;

@end
