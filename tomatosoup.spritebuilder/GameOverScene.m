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
        resultString = (arc4random()%2==0) ? @"Your soup is just tomato water" : @"Your soup lacks a certain je ne sais quoi";
        successString = @"FAILED";
    } else {
        resultString = @"It appears that you made soup! Yum";
    }
    _resultLabel.string = resultString;
    _successLabel.string = successString;
}

- (void)restart {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    CCScene *nextScene = [CCScene node];
    [nextScene addChild:mainScene];
    [[CCDirector sharedDirector] replaceScene:nextScene];
}

- (void)showCredits {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.jessicakwok.com/tomatosoup.html"]];
}



@end
