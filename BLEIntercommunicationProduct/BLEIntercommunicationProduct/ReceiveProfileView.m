//
//  ReceiveProfileView.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/11.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "ReceiveProfileView.h"

@implementation ReceiveProfileView

@synthesize delegate;
@synthesize nameLabel;
@synthesize greetingLabel;
@synthesize profileLabel1;
@synthesize profileLabel2;
@synthesize profileLabel3;
@synthesize twitterNameLabel;
@synthesize facebookNameLabel;
@synthesize mailLabel;

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.borderWidth = 0.5f;//枠線の幅
        self.layer.cornerRadius = 5.0f;//角の丸み
        self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor;//枠線の色
        
        CGSize oneLine = CGSizeMake(self.bounds.size.width, self.bounds.size.height / 9);
        
        CGRect rect1 = CGRectMake(0, 0, oneLine.width, oneLine.height);
        CGRect rect2 = CGRectMake(rect1.origin.x, rect1.origin.y + rect1.size.height, oneLine.width, oneLine.height * 2);
        CGRect rect3 = CGRectMake(rect2.origin.x, rect2.origin.y + rect2.size.height, oneLine.width, oneLine.height);
        CGRect rect4 = CGRectMake(rect3.origin.x, rect3.origin.y + rect3.size.height, oneLine.width, oneLine.height);
        CGRect rect5 = CGRectMake(rect4.origin.x, rect4.origin.y + rect4.size.height, oneLine.width, oneLine.height);
        CGRect rect6 = CGRectMake(rect5.origin.x, rect5.origin.y + rect5.size.height, oneLine.width, oneLine.height);
        CGRect rect7 = CGRectMake(rect6.origin.x, rect6.origin.y + rect6.size.height, oneLine.width, oneLine.height);
        CGRect rect8 = CGRectMake(rect7.origin.x, rect7.origin.y + rect7.size.height, oneLine.width, oneLine.height);
        
        nameLabel = [[HeadLabel alloc]initWithFrame:rect1];
        greetingLabel = [[HeadLabel alloc]initWithFrame:rect2];
        profileLabel1 = [[HeadLabel alloc]initWithFrame:rect3];
        profileLabel2 = [[HeadLabel alloc] initWithFrame:rect4];
        profileLabel3 = [[HeadLabel alloc]initWithFrame:rect5];
        twitterNameLabel = [[HeadLabel alloc]initWithFrame:rect6];
        facebookNameLabel = [[HeadLabel alloc] initWithFrame:rect7];
        mailLabel = [[HeadLabel alloc]initWithFrame:rect8];

        [self addSubview:nameLabel];
        [self addSubview:greetingLabel];
        [self addSubview:profileLabel1];
        [self addSubview:profileLabel2];
        [self addSubview:profileLabel3];
        [self addSubview:twitterNameLabel];
        [self addSubview:facebookNameLabel];
        [self addSubview:mailLabel];
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@",self.nameLabel.text);
    
    if (self.nameLabel.text != nil) {
        [self.delegate touchedReceiveProfileView:self.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
