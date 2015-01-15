//
//  ReceiveProfileView.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/11.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HeadLabel.h"

@protocol ReceiveProfileViewDelegate <NSObject>

- (void)touchedReceiveProfileView:(NSInteger)tag;

@end

@interface ReceiveProfileView : UIView {
    
    BOOL grantContacts;
}

@property (nonatomic, assign) id <ReceiveProfileViewDelegate> delegate;
@property HeadLabel *nameLabel;
@property HeadLabel *greetingLabel;
@property HeadLabel *profileLabel1;
@property HeadLabel *profileLabel2;
@property HeadLabel *profileLabel3;
@property HeadLabel *twitterNameLabel;
@property HeadLabel *facebookNameLabel;
@property HeadLabel *mailLabel;

@end
