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
        resultString = @"Your soup is not edible";
        successString = @"FAILED";
        _creditsButton.visible = NO;
    } else if (self.finalScore < 2) {
        resultString = @"Your soup is just tomato water";
        successString = @"FAILED";
    } else {
        resultString = @"It appears that you made soup! Yum";
        _creditsButton.visible = YES;
    }
    _resultLabel.string = resultString;
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
