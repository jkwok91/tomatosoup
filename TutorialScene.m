//
//  TutorialScene.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TutorialScene.h"

@implementation TutorialScene

- (void)play {
    CCScene *nextScene = [CCBReader loadAsScene:@"MainScene"];
    CCScene *scene = [CCScene node];
    [scene addChild:nextScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end
