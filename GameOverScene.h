//
//  GameOverScene.h
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"

@interface GameOverScene : CCScene

@property (nonatomic,strong) NSString *recipe;
@property (assign) int finalScore;
@property (nonatomic,strong) NSDictionary *results;

@end
