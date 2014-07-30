//
//  Drop.m
//  bling
//
//  Created by Jessica Kwok on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Drop.h"

@implementation Drop{
    CCSprite *_image;
}

- (id)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.fileName = name;
        _image = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Assets/%@.png",self.fileName]];
        _image.anchorPoint = ccp(0,0);
        [self addChild:_image];
        self.contentSize = CGSizeMake(_image.contentSize.width,_image.contentSize.height+10);
        double radius = 0.5*(pow((pow(_image.contentSize.width,2)+pow(_image.contentSize.height,2)),0.5));
        self.anchorPoint = ccp(0.5,0.5);
        self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:radius andCenter:ccp(0.5f, 0.5f)];
    }
    return self;
}

@end
