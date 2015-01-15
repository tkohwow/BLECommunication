//
//  SocialLabel.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/12/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadLabel.h"

@protocol SocialLabelDelegate <NSObject>

- (void)touchedHeadLabel:(NSInteger)tag;

@end

@interface SocialLabel : HeadLabel

@property (nonatomic, assign) id <SocialLabelDelegate> delegate;

@end
