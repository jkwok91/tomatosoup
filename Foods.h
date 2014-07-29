//
//  Constants.h
//  tomatosoup
//
//  Created by Jessica Kwok on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

NSDictionary * (^makeBasil) () = ^() {
    return @{@"name":@"basil",
             @"bbw":[NSNumber numberWithInt:60],
             @"bbh":[NSNumber numberWithInt:65]
             };
};
#define basil makeBasil()


NSDictionary * (^makeOregano) () = ^() {
    return @{@"name":@"oregano",
             @"bbw":[NSNumber numberWithInt:27],
             @"bbh":[NSNumber numberWithInt:27]
             };
};
#define oregano makeOregano()

NSDictionary * (^makeSalt) () = ^() {
    return @{@"name":@"salt",
                       @"bbw":[NSNumber numberWithInt:60],
                       @"bbh":[NSNumber numberWithInt:50]
                       };
};
#define salt makeSalt()

NSDictionary * (^makePepper) () = ^() {
    return @{@"name":@"pepper",
                         @"bbw":[NSNumber numberWithInt:60],
                         @"bbh":[NSNumber numberWithInt:50]
                         };
};
#define pepper makePepper()

NSDictionary * (^makeSpaghetti) () = ^() {
  return @{@"name":@"spaghetti",
                            @"bbw":[NSNumber numberWithInt:115],
                            @"bbh":[NSNumber numberWithInt:45]
                            };
};
#define spaghetti makeSpaghetti()

NSDictionary * (^makeBaguette) () = ^() {
  return @{@"name":@"baguette",
                           @"bbw":[NSNumber numberWithInt:130],
                           @"bbh":[NSNumber numberWithInt:30]
                           };
};
#define baguette makeBaguette()

NSDictionary * (^makeTomato) () = ^() {
    return @{@"name":@"tomato",
                         @"bbw":[NSNumber numberWithInt:45],
                         @"bbh":[NSNumber numberWithInt:40]
                         };
};
#define tomato makeTomato()

NSDictionary * (^makeOnion) () = ^() {
    return @{@"name":@"onion",
                        @"bbw":[NSNumber numberWithInt:45],
                        @"bbh":[NSNumber numberWithInt:40]
                        };
};
#define onion makeOnion()

NSDictionary * (^makeGarlic) () = ^() {
    return @{@"name":@"garlic",
                         @"bbw":[NSNumber numberWithInt:50],
                         @"bbh":[NSNumber numberWithInt:45]
                         };
};
#define garlic makeGarlic()

NSDictionary * (^makeButter) () = ^() {
    return @{@"name":@"butter",
                         @"bbw":[NSNumber numberWithInt:50],
                         @"bbh":[NSNumber numberWithInt:32]
                         };
};
#define butter makeButter()

NSDictionary * (^makeOliveOil) () = ^() {
    return @{@"name":@"oliveOil",
                           @"bbw":[NSNumber numberWithInt:31],
                           @"bbh":[NSNumber numberWithInt:82]
                           };
};
#define oliveOil makeOliveOil()

/*
NSDictionary * (^makeBV) () = ^() {
    return @{@"name":@"vinegar",
                            @"bbw":[NSNumber numberWithInt:57],
                            @"bbh":[NSNumber numberWithInt:65]
                            };
 };
 #define vinegar makeBV()
 */

NSDictionary * (^makeStrawberry) () = ^() {
  return @{@"name":@"strawberry",
                             @"bbw":[NSNumber numberWithInt:40],
                             @"bbh":[NSNumber numberWithInt:35]
                             };
};
#define strawberry makeStrawberry()

NSDictionary * (^makeVE) () = ^() {
    return @{@"name":@"VE",
                                 @"bbw":[NSNumber numberWithInt:25],
                                 @"bbh":[NSNumber numberWithInt:45]
                                 };
};
#define vanillaExtract makeVE()

NSDictionary * (^makeEgg) () = ^() {
  return @{@"name":@"egg",
                      @"bbw":[NSNumber numberWithInt:25],
                      @"bbh":[NSNumber numberWithInt:30]
                      };
};
#define egg makeEgg()

NSDictionary * (^makeFlour) () = ^() {
  return @{@"name":@"flour",
                        @"bbw":[NSNumber numberWithInt:45],
                        @"bbh":[NSNumber numberWithInt:50]
                        };
};
#define flour makeFlour()

NSDictionary * (^makeSugar) () = ^() {
  return @{@"name":@"sugar_bag",
                        @"bbw":[NSNumber numberWithInt:45],
                        @"bbh":[NSNumber numberWithInt:50]
                        };
};
#define sugar makeSugar()

NSDictionary * (^makeMilk) () = ^() {
  return @{@"name":@"milk",
                       @"bbw":[NSNumber numberWithInt:31],
                       @"bbh":[NSNumber numberWithInt:53]
                       };
};
#define milk makeMilk()

