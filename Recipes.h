//
//  Recipes.h
//  tomatosoup
//
//  Created by Jessica Kwok on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Foods.h"
#import "Cookware.h"
// recipes

// APPETIZERS
NSDictionary * (^cookTomatoSoup) () = ^() {
    return @{@"name":@"soup",
             @"extras": @[basil],
             @"seasonings": @[salt,pepper],
             @"bases": @[tomato,butter],
             @"reset": @[pot]
             };
};
#define tomatoSoup cookTomatoSoup()

NSDictionary * (^cookBruschetta) () = ^() {
  return @{@"name":@"bruschetta",
                                          @"extras": @[basil,onion],
                                          @"seasonings": @[salt,pepper],
                                          @"bases": @[tomato,baguette,garlic,oliveOil],
                                          @"reset": @[bowl]
                                          };
};
#define bruschetta cookBruschetta()

// ENTREES
NSDictionary * (^cookPasta) () = ^() {
    return @{@"name":@"pasta",
             @"extras": @[basil,butter,oregano],
             @"seasonings": @[salt,pepper],
             @"bases": @[tomato,garlic,spaghetti,oliveOil],
             @"reset": @[pot]
             };
};
#define pasta cookPasta()

// DESSERTS
NSDictionary * (^cookCake) () = ^() {
    return @{@"name":@"cake",
                                    @"extras": @[strawberry],
                                    @"seasonings": @[sugar,vanillaExtract],
                                    @"bases": @[egg, flour, salt, milk],
                                    @"reset": @[bakingPan]
                                    };
};
#define cake cookCake()
