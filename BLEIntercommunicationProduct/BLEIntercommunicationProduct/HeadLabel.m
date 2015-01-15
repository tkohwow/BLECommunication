//
//  HeadLabel.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/07.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "HeadLabel.h"

@implementation HeadLabel

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //self.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:20];
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 0;
        self.adjustsFontSizeToFitWidth = YES;
        self.minimumScaleFactor = 0.5f;
        
        self.userInteractionEnabled = YES;
    }

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
