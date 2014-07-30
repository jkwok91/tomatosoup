//
//  Cookware.h
//  tomatosoup
//
//  Created by Jessica Kwok on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

// cookingTools (RESET)
NSDictionary *(^getPot) () = ^() {
  return @{@"name":@"pot"
                      };
};
#define pot getPot()

NSDictionary *(^getPan) () = ^() {
  return @{@"name":@"baking_pan"
                            };
};
#define bakingPan getPan()

NSDictionary *(^getBowl) () = ^() {
  return @{@"name":@"bowl"
                       };
};
#define bowl getBowl()