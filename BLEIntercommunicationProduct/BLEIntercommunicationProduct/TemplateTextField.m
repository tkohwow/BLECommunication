//
//  TemplateTextField.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/07.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "TemplateTextField.h"

@implementation TemplateTextField

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDone;
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
