//
//  SocialLabel.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/12/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "SocialLabel.h"

@implementation SocialLabel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        self.alpha = 0.5;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.delegate touchedHeadLabel:self.tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
