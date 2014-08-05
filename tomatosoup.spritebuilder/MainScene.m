//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//  Created by Jessica on 21/7/13.
//

#import "MainScene.h"
#import "GameOverScene.h"
#import "Drop.h"

@implementation MainScene {
    // array to keep track of what drops are on screen
    NSMutableArray *_drops;
    // physics
    CCPhysicsNode *_physicsNode;
    // keep track of score
    CCLabelTTF *_scoreLabel;
    // later: also change bg color according to score-- with a transition
}

- (id)init {
    if (self = [super init]) {
        self.timeLeft = 5;
        self.points = 1;
        _drops = [NSMutableArray array];
    }
    return self;
}

- (void)didLoadFromCCB {
    //put a bunch of drops in the array and also on screen
    int numDrops = arc4random()%30+50;
    for (int i = 0; i < numDrops; i++) {
        Drop *d = [self generateDrop];
        d.position = ccp(100+i,250+2*i); //magik numbaaazzz
        [_drops addObject:d];
        [_physicsNode addChild:d];
    }
}

- (Drop *)generateDrop {
    Drop *d;
    int randomizer = arc4random()%40;
    if (randomizer < 18) { // 45% chance of creating a neutral drop
        d = (Drop *)[CCBReader load:@"gems/gem1x"];
        d.multiplier = 1.01;
    }
    else if (randomizer < 21) { // 7.5% chance of creating a double drop
        d = (Drop *)[CCBReader load:@"gems/gem2x"];
        d.multiplier = 2;
    }
    else if (randomizer < 29) { // 20% chance of creating a fractional drop
        d = (Drop *)[CCBReader load:@"gems/gem1-4x"];
        d.multiplier = (arc4random()%2 == 0) ? 0.75 : 1.25;
    }
    else if (randomizer < 39) { // 25% chance of creating a moldy drop
        d = (Drop *)[CCBReader load:@"gems/gem-1x"];
        d.multiplier = -1;
    }
    else { // 2.5% chance of creating a reset drop
        d = (Drop *)[CCBReader load:@"gems/gem0x"];
        d.multiplier = 0;
    }
    return d;
}

- (void)onEnter {
    [super onEnter];
    
    // accept touches
    self.userInteractionEnabled = YES;
    [self scheduleOnce:@selector(endGame) delay:10.0f];
}

- (void)update:(CCTime)delta {
    // decrement timer
    
    // view score
    _scoreLabel.string = [NSString stringWithFormat:@"%f", self.points];
    
    // check which drops have left the screen / generate new ones at top of screen
    for (int i = [_drops count]-1; i >= 0; i--) {
        Drop *d = _drops[i];
        if (d.position.y < 0) {
            [_physicsNode removeChild:d];
            [_drops removeObject:d];
            Drop *b = [self generateDrop];
            b.position = ccp(200,500);
            [_drops addObject:b];
            [_physicsNode addChild:b];
        }
    }
}

- (void)endGame {
    GameOverScene *nextScene = (GameOverScene *)[CCBReader load:@"GameOverScene"];
    nextScene.finalScore = self.points;
    [[CCDirector sharedDirector] replaceScene:nextScene];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touched = [touch locationInNode:self];
    // if touched is a drop, then get that drop's multiplier and apply to score
    for (int i = [_drops count]-1; i >= 0; i--) {
        Drop *d = _drops[i];
        CGRect bbox = CGRectMake(d.position.x,
                                 d.position.y,
                                 d.contentSize.width,
                                 d.contentSize.height);
        if (CGRectContainsPoint(bbox, touched)) {
            float multiplier = d.multiplier;
            //NSLog(@"yo you touched a thing with multiplier %f",multiplier);
            // if score is already negative and you clicked on another negative multiplier, it is doubly bad
            // the real life analogy for this is, if you mixed in a bad ingredient, your food is now bad. if you mix in another bad ingredient, your food is worse.
            if (self.points < 0 && multiplier < 0) {
                multiplier *= -2;
            }
            self.points *= multiplier;
            if (self.points == 0) { self.points++; }
            [_physicsNode removeChild:d];
            [_drops removeObject:d];
        }
    }
}

@end
