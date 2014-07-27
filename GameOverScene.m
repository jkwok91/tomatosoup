//
//  GameOverScene.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene{
    CCLabelTTF *_resultLabel;
    CCLabelTTF *_successLabel;
    CCLabelTTF *_creditsLabel;
    CCButton *_creditsButton;
}

- (void)onEnter {
    [super onEnter];
    _creditsLabel.visible = NO;
    _creditsButton.visible = NO;
    NSString *resultString;
    NSString *successString = @"SUCCESS";
    if (self.finalScore < 0) {
        resultString = @"Your %@ is not edible";
        successString = @"FAILED";
        _creditsButton.visible = NO;
    } else if (self.finalScore%2 != 0) {
        resultString = @"Your %@ lacks tomatoes!";
        successString = @"FAILED";
    } else if (self.finalScore%3 != 0) {
        resultString = @"Your %@ is just tomato water!"; // need to change out some of these statements
        successString = @"FAILED";
    } else if (self.finalScore%5 != 0) {
        resultString = @"Your %@ lacks a certain je ne sais quoi...";
        successString = @"NEEDS IMPROVEMENT";
    } else if (self.finalScore <= 30000) {
        resultString = @"It appears that you made %@! Yum";
        _creditsButton.visible = YES;
    } else if (self.finalScore <= 300000) {
        resultString = @"This %@ is amazing! And there was enough for both of us!";
        _creditsButton.visible = YES;
    } else {
        resultString = @"You're the god of %@.";
        _creditsButton.visible = YES;
    }
    _resultLabel.string = [NSString stringWithFormat:resultString,self.recipe];
    _successLabel.string = successString;
}

- (void)restart {
    CCScene *nextScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:nextScene];
}

- (void)showCredits {
    _creditsButton.visible = NO;
    _creditsLabel.visible = YES;
    _creditsLabel.string = @"I could not have done this without MGWU, Daniel Haaser, Zach Barryte, Eric Braen, Jack Vittimberga, Frank Navarro-Velasco, Hans Yadav, and Phillip Ou. With love to Tala Huhe, Mike Comella, Nathan Malkin, Emily Phillips, and Misha Bhandari.";
}



@end
