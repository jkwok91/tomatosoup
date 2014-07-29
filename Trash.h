//
//  Trash.h
//  tomatosoup
//
//  Created by Jessica Kwok on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

// the trash can
// aka rotten food
NSDictionary * (^makeMoldyStrawberry) () = ^() {
    return @{@"name":@"moldyStrawberry",
                                  @"bbw":[NSNumber numberWithInt:50],
                                  @"bbh":[NSNumber numberWithInt:45]
                                  };
};
#define moldyStrawberry makeMoldyStrawberry()

NSDictionary * (^makeMoldyBread) () = ^() {
    return @{@"name":@"moldyBread",
                             @"bbw":[NSNumber numberWithInt:130],
                             @"bbh":[NSNumber numberWithInt:30]
                             };
};
#define moldyBread makeMoldyBread()