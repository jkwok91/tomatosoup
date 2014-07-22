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
}

- (void)onEnter {
    [super onEnter];
    NSString *resultString;
    NSString *successString = @"SUCCESS";
    if (self.finalScore < 0) {
        resultString = @"Your soup is not edible";
        successString = @"FAILED";
    } else if (self.finalScore < 2) {
        resultString = @"Your soup is just tomato water";
        successString = @"FAILED";
    } else {
        resultString = @"It appears that you made soup! Yum";
    }
    _resultLabel.string = resultString;
    _successLabel.string = successString;
}

- (void)restart {
    CCScene *nextScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:nextScene];
}



@end
