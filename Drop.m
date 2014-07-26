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

- (id)initWithName:(NSString *)name andW:(int)w andH:(int)h {
    if (self = [super init]) {
        self.fileName = name;
        self.bbWidth = w;
        self.bbHeight = h;
        _image = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Assets/%@.png",self.fileName]];
        _image.anchorPoint = ccp(0,0);
        [self addChild:_image];
        self.contentSize = CGSizeMake(self.bbWidth,self.bbHeight);
        double radius = 0.5*(pow((pow(self.bbWidth,2)+pow(self.bbHeight,2)),0.5));
        self.anchorPoint = ccp(0.5,0.5);
        self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:radius andCenter:ccp(0.5f, 0.5f)];
    }
    return self;
}

@end
