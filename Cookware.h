//
//  Cookware.h
//  tomatosoup
//
//  Created by Jessica Kwok on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

// cookingTools (RESET)
NSDictionary *(^getPot) () = ^() {
  return @{@"name":@"pot",
                      @"bbw":[NSNumber numberWithInt:90],
                      @"bbh":[NSNumber numberWithInt:60]
                      };
};
#define pot getPot()

NSDictionary *(^getPan) () = ^() {
  return @{@"name":@"baking_pan",
                            @"bbw":[NSNumber numberWithInt:75],
                            @"bbh":[NSNumber numberWithInt:45]
                            };
};
#define bakingPan getPan()

NSDictionary *(^getBowl) () = ^() {
  return @{@"name":@"bowl",
                       @"bbw":[NSNumber numberWithInt:60],
                       @"bbh":[NSNumber numberWithInt:35]
                       };
};
#define bowl getBowl()