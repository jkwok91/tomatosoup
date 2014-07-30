//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//  Created by Jessica on 21/7/13.
//

#import "Recipes.h"
#import "Trash.h"
#import "MainScene.h"
#import "Drop.h"
#import "GameOverScene.h"

static int course = 0;

@implementation MainScene {
    NSArray *rotten; // nasty food
    NSArray *cookbook;
    // which recipe is being made?
    NSString *_recipeName;
    NSDictionary *_currentRecipe;
    // array to keep track of what drops are on screen
    NSMutableArray *_drops;
    
    // physics
    CCPhysicsNode *_physicsNode;
    
    // what am i making
    CCLabelTTF *_statusLabel;
    // keep track of score
    CCLabelTTF *_scoreLabel;
    // time left
    float _timeLeft;
    // what did you add just now
    NSMutableDictionary *_inThePot;
}

- (id)init {
    if (self = [super init]) {
        // load up the cookbook
        cookbook = @[
                     tomatoSoup, // TOMATO SOUP 4 REAL
                     bruschetta,
                     pasta,
                     cake // CAKE
                     ];
        
        rotten = @[moldyStrawberry,moldyBread]; //,rottenMilk,rottenEgg,badPepper];
        
        _currentRecipe = [cookbook objectAtIndex:course%[cookbook count]]; //arc4random()%(int)[cookbook count];
        _recipeName = [_currentRecipe valueForKey:@"name"];
        _timeLeft = 10.0;
        for (int i = 0; i < course; i++) {
            _timeLeft -= 1.0/(1+i);
        }
        self.points = 1;
        _drops = [NSMutableArray array];
        _inThePot = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)didLoadFromCCB {
    _statusLabel.string = [NSString stringWithFormat:@"You're attempting to make %@ (course #%i)",_recipeName,course+1];
    //put a bunch of drops in the array and also on screen
    int numDrops = arc4random()%30+30;
    for (int i = 0; i < numDrops; i++) {
        Drop *d = [self generateDrop];
        d.position = ccp(100+i,250+2*i);
        [_drops addObject:d];
        [_physicsNode addChild:d];
    }
}

- (Drop *)makeDrop:(NSArray *)arr{
    int rand = arc4random()%[arr count];
    NSDictionary *dict = arr[rand];
    NSString *fileName = [dict valueForKey:@"name"];
    int w = [[dict valueForKey:@"bbw"] intValue];
    int h = [[dict valueForKey:@"bbh"] intValue];
    return [[Drop alloc] initWithName:fileName andW:w andH:h];
}

- (Drop *)generateDrop {
    NSArray *fromThese;
    Drop *d;
    int randomizer = arc4random()%40;
    if (randomizer < 18) { // 45% chance of creating a neutral drop
        //NSLog(@"generating a neutr drop");
        fromThese = [_currentRecipe valueForKey:@"bases"];
        d = [self makeDrop:fromThese];
        d.multiplier = 2;
    }
    else if (randomizer < 20) { // 5% chance of creating a double drop
        //NSLog(@"generating a doub drop");
        fromThese = [_currentRecipe valueForKey:@"seasonings"];
        d = [self makeDrop:fromThese];
        d.multiplier = 3;
    }
    else if (randomizer < 21) { // 2.5% chance of creating a triple drop
        //NSLog(@"generating a trip drop");
        fromThese = [_currentRecipe valueForKey:@"extras"];
        d = [self makeDrop:fromThese];
        d.multiplier = 5;
    }
    else if (randomizer < 39) { // 45% chance of creating a moldy drop
        //NSLog(@"generating a moldy drop");
        d = [self makeDrop:rotten];
        d.multiplier = -1;
    }
    else { // 2.5% chance of creating a reset drop
        //NSLog(@"generating a reset drop");
        d = [self makeDrop:[_currentRecipe valueForKey:@"reset"]];
        d.multiplier = 0;
    }
    return d;
}

- (void)onEnter {
    [super onEnter];
    
    // accept touches
    self.userInteractionEnabled = YES;
    [self scheduleOnce:@selector(endGame) delay:_timeLeft];
}

- (void)update:(CCTime)delta {
    // decrement timer
    
    // view score
    _scoreLabel.string = [NSString stringWithFormat:@"%i", self.points];
    
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
    nextScene.recipe = _recipeName;
    nextScene.finalScore = self.points;
    nextScene.results = _inThePot;
    if (self.points > 0 && self.points%30 == 0) { course++; }
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
            // if score is already negative and you clicked on another negative multiplier, it is doubly bad
            // the real life analogy for this is, if you mixed in a bad ingredient, your food is now bad. if you mix in another bad ingredient, your food is worse.
            if (self.points < 0 && multiplier < 0) {
                multiplier *= -2;
            }
            if (multiplier == 0) {
                self.points = 1;
                [_inThePot removeAllObjects];
            } else {
                self.points *= multiplier;
                // add it to the pot
                NSString *keyName = [d.fileName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                if (_inThePot[keyName]) {
                    [_inThePot setValue:@([_inThePot[keyName] intValue]+1) forKey:keyName];
                } else {
                    [_inThePot setValue:[NSNumber numberWithInt:1] forKey:keyName];
                }
            }
            
            // LIL ANIMATION RIGHT HERE
            CCSprite *poof = (CCSprite *)[CCBReader load:@"spark"];
            [self addChild:poof];
            poof.position = ccp(d.position.x,d.position.y);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeChild:poof];
            });
            // clear that drop from view
            [_physicsNode removeChild:d];
            [_drops removeObject:d];
        }
    }
}

@end
