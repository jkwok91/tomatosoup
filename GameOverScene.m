//
//  GameOverScene.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AppDelegate.h"
#import <Social/Social.h>
#import "GameOverScene.h"

@implementation GameOverScene{
    CCLabelTTF *_itemsLabel;
    CCLabelTTF *_resultLabel;
    CCLabelTTF *_successLabel;
    CCLabelTTF *_creditsLabel;
    CCButton *_creditsButton;
    CCSprite *_successSprite;
    NSString *_song;
    
    NSString *_tweetText;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.viewController = [[UIViewController alloc] init];
    }
    return self;
}

- (void)onEnter {
    [super onEnter];
    _creditsLabel.visible = NO;
    _creditsButton.visible = NO;
    NSString *resultString;
    BOOL success = NO;
    NSString *successString = @"FAILED";
    _song = @"worstNoise.mp3";
    if (self.finalScore < -300000) {
        resultString = @"You're disgusting.";
        _tweetText = @"I heart mold.";
    } else if (self.finalScore < -3000) {
        resultString = @"I ain't eatin' this.";
        _tweetText = [NSString stringWithFormat:@"I failed to make %@ because I am a really terrible chef.",self.recipe];
    } else if (self.finalScore < 0) {
        resultString = @"You've got mold in your %@! You used some bad ingredients!";
        _tweetText = [NSString stringWithFormat:@"I failed to make %@ because I am a terrible chef.",self.recipe];
    } else if (self.finalScore%2 != 0) {
        resultString = @"Your %@ lacks some core ingredients!";
        _tweetText = [NSString stringWithFormat:@"I failed to make %@ because I am a terrible chef.",self.recipe];
    } else if (self.finalScore%3 != 0) {
        resultString = @"Your %@ is just bland mishmash!";
    } else if (self.finalScore%5 != 0) {
        resultString = @"Your %@ lacks a certain je ne sais quoi...";
        successString = @"ALMOST"; // thanks, lucy liu, for giving that speech about almost being the worst word in the language
        _tweetText = [NSString stringWithFormat:@"I just made mediocre %@ because I am a terrible chef.",self.recipe];
    } else if (self.finalScore <= 30000) {
        resultString = @"It appears that you made %@! Yum.";
        success = YES;
        _tweetText = [NSString stringWithFormat:@"I just made %@!",self.recipe];
    } else if (self.finalScore <= 300000) {
        resultString = @"This %@ is amazing! And there was enough for both of us!";
        success = YES;
        _tweetText = [NSString stringWithFormat:@"I just made %@! Yay!",self.recipe];
    } else {
        resultString = @"You're the god of %@.";
        success = YES;
        _tweetText = [NSString stringWithFormat:@"I'm the god of %@.",self.recipe];
    }
    if (success) {
        _song = @"arpeggio1.mp3";
        CCLOG(@"success! position of sprite is %f,%f",_successSprite.anchorPoint.x,_successSprite.anchorPoint.y);
        _successSprite.spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"Assets/completed_%@.png",self.recipe]];
        _creditsButton.visible = YES;
        _successLabel.visible = NO;
    }
    _itemsLabel.string = [self getAll];
    _resultLabel.string = [NSString stringWithFormat:resultString,self.recipe];
    _successLabel.string = successString;
    [[OALSimpleAudio sharedInstance] playBg:_song];
}

- (IBAction)tweetMe:(id)sender {
    // TODO test this tomorrow
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:_tweetText];
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![tweetSheet addURL:[NSURL URLWithString:@"http://www.jessicakwok.com/"]]){
            NSLog(@"Unable to add the URL!");
        }
        // create reference to appcontroller which is the root UIKit view
        AppController *appController = (AppController *)[[UIApplication sharedApplication] delegate];
        // put tweetsheet in navController, then presented it in navController
        [appController.navController presentViewController:tweetSheet animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
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
    [[OALSimpleAudio sharedInstance] stopBg];
    CCScene *nextScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:nextScene];
}

- (void)showCredits {
    _creditsButton.visible = NO;
    _creditsLabel.visible = YES;
}



@end
