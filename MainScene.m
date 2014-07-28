//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//  Created by Jessica on 21/7/13.
//

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
}

- (id)init {
    if (self = [super init]) {
        // okay i know what's up. i am creating instances of drops and trying to treat them like classes. i see now. okay. so i just need to store this in another sort of way, and then feed that information into drops and actually create the drops when i'm in the fn generateDrops
        // i did this but now they aint casting properly
        // my fridge, which i will eventually move out of this document
        // aka all foods
        NSDictionary *basil = @{@"name":@"basil",
                                @"bbw":[NSNumber numberWithInt:60],
                                @"bbh":[NSNumber numberWithInt:65]
                                };
        NSDictionary *oregano = @{@"name":@"oregano",
                                  @"bbw":[NSNumber numberWithInt:27],
                                  @"bbh":[NSNumber numberWithInt:27]
                                  };
        NSDictionary *salt = @{@"name":@"salt",
                               @"bbw":[NSNumber numberWithInt:60],
                               @"bbh":[NSNumber numberWithInt:50]
                               };
        NSDictionary *pepper = @{@"name":@"pepper",
                                 @"bbw":[NSNumber numberWithInt:60],
                                 @"bbh":[NSNumber numberWithInt:50]
                                 };
        NSDictionary *spaghetti = @{@"name":@"spaghetti",
                                  @"bbw":[NSNumber numberWithInt:115],
                                  @"bbh":[NSNumber numberWithInt:45]
                                  };
        NSDictionary *baguette = @{@"name":@"baguette",
                                   @"bbw":[NSNumber numberWithInt:130],
                                   @"bbh":[NSNumber numberWithInt:30]
                                   };
        NSDictionary *tomato = @{@"name":@"tomato",
                                 @"bbw":[NSNumber numberWithInt:45],
                                 @"bbh":[NSNumber numberWithInt:40]
                                 };
        NSDictionary *onion = @{@"name":@"onion",
                                 @"bbw":[NSNumber numberWithInt:45],
                                 @"bbh":[NSNumber numberWithInt:40]
                                 };
        NSDictionary *garlic = @{@"name":@"garlic",
                                  @"bbw":[NSNumber numberWithInt:50],
                                  @"bbh":[NSNumber numberWithInt:45]
                                  };
        NSDictionary *butter = @{@"name":@"butter",
                                 @"bbw":[NSNumber numberWithInt:50],
                                 @"bbh":[NSNumber numberWithInt:32]
                                 };
        NSDictionary *oliveOil = @{@"name":@"oliveOil",
                                   @"bbw":[NSNumber numberWithInt:31],
                                   @"bbh":[NSNumber numberWithInt:82]
                                   };
        NSDictionary *balsamicV = @{@"name":@"vinegar",
                                   @"bbw":[NSNumber numberWithInt:57],
                                   @"bbh":[NSNumber numberWithInt:65]
                                   };
        
        NSDictionary *strawberry = @{@"name":@"strawberry",
                                     @"bbw":[NSNumber numberWithInt:40],
                                     @"bbh":[NSNumber numberWithInt:35]
                                     };
        NSDictionary *vanillaExtract = @{@"name":@"VE",
                                         @"bbw":[NSNumber numberWithInt:25],
                                         @"bbh":[NSNumber numberWithInt:45]
                                         };
        NSDictionary *egg = @{@"name":@"egg",
                              @"bbw":[NSNumber numberWithInt:25],
                              @"bbh":[NSNumber numberWithInt:30]
                              };
        NSDictionary *flour = @{@"name":@"flour",
                                @"bbw":[NSNumber numberWithInt:45],
                                @"bbh":[NSNumber numberWithInt:50]
                                };
        NSDictionary *sugar = @{@"name":@"sugar_bag",
                                @"bbw":[NSNumber numberWithInt:45],
                                @"bbh":[NSNumber numberWithInt:50]
                                };
        NSDictionary *milk = @{@"name":@"milk",
                               @"bbw":[NSNumber numberWithInt:31],
                               @"bbh":[NSNumber numberWithInt:53]
                               };
        
        // cookingTools (RESET)
        NSDictionary *pot = @{@"name":@"pot",
                              @"bbw":[NSNumber numberWithInt:90],
                              @"bbh":[NSNumber numberWithInt:60]
                              };
        NSDictionary *bakingPan = @{@"name":@"bakingPan",
                                    @"bbw":[NSNumber numberWithInt:75],
                                    @"bbh":[NSNumber numberWithInt:45]
                                    };
        NSDictionary *bowl = @{@"name":@"bowl",
                               @"bbw":[NSNumber numberWithInt:60],
                               @"bbh":[NSNumber numberWithInt:35]
                               };
        // recipes
        NSDictionary *tomatoSoup = @{@"name":@"soup",
                                     @"extras": @[basil],
                                     @"seasonings": @[salt,pepper],
                                     @"bases": @[tomato,butter],
                                     @"reset": @[pot]};
        
        NSDictionary *bruschetta = @{@"name":@"bruschetta",
                                     @"extras": @[basil,onion],
                                     @"seasonings": @[salt,pepper,balsamicV],
                                     @"bases": @[tomato,baguette,garlic,oliveOil],
                                     @"reset": @[bowl]};
        
        NSDictionary *pasta = @{@"name":@"pasta",
                                @"extras": @[basil,butter,oregano],
                                @"seasonings": @[salt,pepper],
                                @"bases": @[tomato,garlic,spaghetti,oliveOil],
                                @"reset": @[pot]
                                };
        
        NSDictionary *cake = @{@"name":@"cake",
                               @"extras": @[strawberry],
                               @"seasonings": @[salt,vanillaExtract],
                               @"bases": @[egg, flour, sugar, milk],
                               @"reset": @[bakingPan]};
        // load up the cookbook
        cookbook = @[
                   tomatoSoup, // TOMATO SOUP 4 REAL
                   bruschetta,
                   pasta,
                   cake // CAKE
                   ];
        // the trash can
        // aka rotten food
        NSDictionary *moldyStrawberry = @{@"name":@"moldyStrawberry",
                                          @"bbw":[NSNumber numberWithInt:50],
                                          @"bbh":[NSNumber numberWithInt:45]
                                          };
        NSDictionary *moldyBread = @{@"name":@"moldyBread",
                                          @"bbw":[NSNumber numberWithInt:130],
                                          @"bbh":[NSNumber numberWithInt:30]
                                          };
//        MoldyDrop *rottenMilk = [[MoldyDrop alloc] initWithName:@"rottenMilk" andW:500 andH:500];
//        MoldyDrop *rottenEgg = [[MoldyDrop alloc] initWithName:@"rottenEgg" andW:500 andH:500];
//        MoldyDrop *badPepper = [[MoldyDrop alloc] initWithName:@"badPepper" andW:500 andH:500];
        
        rotten = @[moldyStrawberry,moldyBread]; //,rottenMilk,rottenEgg,badPepper];
        
        _currentRecipe = [cookbook objectAtIndex:course%[cookbook count]]; //arc4random()%(int)[cookbook count];
        _recipeName = [_currentRecipe valueForKey:@"name"];
        _timeLeft = 10.0/(1+course);
        self.points = 1;
        _drops = [NSMutableArray array];
    }
    return self;
}

- (void)didLoadFromCCB {
    _statusLabel.string = _recipeName;
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
    //NSLog(@": %@,%i,%i",fileName,w,h);
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
            //NSLog(@"yo you touched a thing with multiplier %f",multiplier);
            // if score is already negative and you clicked on another negative multiplier, it is doubly bad
            // the real life analogy for this is, if you mixed in a bad ingredient, your food is now bad. if you mix in another bad ingredient, your food is worse.
            //NSLog(@"multiplier is %f",multiplier);
            if (self.points < 0 && multiplier < 0) {
                multiplier *= -2;
            }
            self.points *= multiplier;
            if (self.points == 0) { self.points++; }
            // LIL ANIMATION RIGHT HERE
            CCSprite *poof = (CCSprite *)[CCBReader load:@"spark"];
            [self addChild:poof];
            poof.position = ccp(d.position.x,d.position.y);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeChild:poof];
            });
            [_physicsNode removeChild:d];
            [_drops removeObject:d];
        }
    }
}

@end
