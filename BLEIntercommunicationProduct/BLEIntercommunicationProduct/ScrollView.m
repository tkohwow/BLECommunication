//
//  ScrollView.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/07.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        self.tag = 1;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.delegate touchedScrollView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
