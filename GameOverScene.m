//
//  GameOverScene.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene{
    CCLabelTTF *_itemsLabel;
    CCLabelTTF *_resultLabel;
    CCLabelTTF *_successLabel;
    CCLabelTTF *_creditsLabel;
    CCButton *_creditsButton;
    CCSprite *_successSprite;
}

- (void)onEnter {
    [super onEnter];
    _creditsLabel.visible = NO;
    _creditsButton.visible = NO;
    NSString *resultString;
    BOOL success = NO;
    NSString *successString = @"FAILED";
    if (self.finalScore < -300000) {
        resultString = @"You're disgusting.";
    } else if (self.finalScore < -3000) {
        resultString = @"I ain't eatin' this.";
    } else if (self.finalScore < 0) {
        resultString = @"You've got mold in your %@! You used some bad ingredients!";
    } else if (self.finalScore%2 != 0) {
        resultString = @"Your %@ lacks some core ingredients!";
    } else if (self.finalScore%3 != 0) {
        resultString = @"Your %@ is just bland mishmash!";
    } else if (self.finalScore%5 != 0) {
        resultString = @"Your %@ lacks a certain je ne sais quoi...";
        successString = @"ALMOST"; // thanks, lucy liu, for giving that speech about almost being the worst word in the language
    } else if (self.finalScore <= 30000) {
        resultString = @"It appears that you made %@! Yum.";
        success = YES;
    } else if (self.finalScore <= 300000) {
        resultString = @"This %@ is amazing! And there was enough for both of us!";
        success = YES;
    } else {
        resultString = @"You're the god of %@.";
        success = YES;
    }
    if (success) {
        CCLOG(@"success! position of sprite is %f,%f",_successSprite.anchorPoint.x,_successSprite.anchorPoint.y);
        _successSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"Assets/completed_%@.png",self.recipe]];
        _creditsButton.visible = YES;
        _successLabel.visible = NO;
    }
    _itemsLabel.string = [self getAll];
    _resultLabel.string = [NSString stringWithFormat:resultString,self.recipe];
    _successLabel.string = successString;
}

- (NSString *)getAll {
    NSString *_allFoods = @"";
    if ([self.results count] == 0) {
        _allFoods = @"You didn't cook anything!";
    }
    for (NSString *key in self.results) {
        _allFoods = [NSString stringWithFormat:@"%@ %@  x%i\n",_allFoods,key,[self.results[key] intValue]];
    }
    return _allFoods;
}

- (void)restart {
    CCScene *nextScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:nextScene];
}

- (void)showCredits {
    _creditsButton.visible = NO;
    _creditsLabel.visible = YES;
}



@end
