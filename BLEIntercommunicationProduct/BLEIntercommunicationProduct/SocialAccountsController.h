//
//  SocialAccountsController.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/26.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@interface SocialAccountsController : NSObject{
    ACAccountStore* accountStore;
}

- (void)getTwitterAccount;
- (void)getFacebookAccount;

@end
