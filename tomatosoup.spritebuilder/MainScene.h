//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface MainScene : CCNode

@property (assign) int timeLeft;
@property (assign) float points;
// array to keep track of what drops are on screen
@property (nonatomic,strong) NSMutableArray *drops;

@end
