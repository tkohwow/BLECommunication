//
//  InputViewController.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/06.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SocialAccountsController.h"
#import "ScrollView.h"
#import "HeadLabel.h"
#import "SocialLabel.h"
#import "TemplateTextField.h"

@interface InputViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, ScrollViewDelegate, SocialLabelDelegate>{
    
    ScrollView      *scrollView;
    
    NSString *nameString;
    NSString *greetingString;
    NSString *profileString[3];
    NSString *mailString;
    NSString *permitStwitch[3];

    NSUserDefaults  *userDefaults;
    
    SocialLabel *twitterIDLabel;
    SocialLabel *facebookIDLabel;
}

@end
