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
    return @{@"name":@"moldy_strawberry"
                                  };
};
#define moldyStrawberry makeMoldyStrawberry()

NSDictionary * (^makeMoldyBread) () = ^() {
    return @{@"name":@"moldy_bread"
                             };
};
#define moldyBread makeMoldyBread()