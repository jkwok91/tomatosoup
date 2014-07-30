//
//  Drop.h
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Drop : CCNode

@property (assign) float multiplier;
@property (nonatomic,strong) NSString *fileName;
@property (assign) int bbWidth;
@property (assign) int bbHeight;

- (id)initWithName:(NSString *)name;

@end
