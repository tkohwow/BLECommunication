//
//  SocialAccountsController.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/26.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "SocialAccountsController.h"

#define _STFacebookAppID @"629371870505875"

@implementation SocialAccountsController

- (id)init{
    
    self = [super init];
    if (self) {
        
        accountStore = [[ACAccountStore alloc] init];
    
    }
    
    return self;
}

- (void)getTwitterAccount{
   
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
            if ([accountsArray count] > 0) {
                // 複数連携されてる場合もあるよ
                ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                
                NSData *accountData = [twitterAccount.username dataUsingEncoding:NSUTF8StringEncoding];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:accountData forKey:@"twitterName"];
                
            }
        } else {
            // ユーザーにアカウントへのアクセス拒否されたりするとこっちに来るよ
        }
    }];
}

- (void)getFacebookAccount{
    
    ACAccountType *accountTypeFacebook = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    //NSArray *accounts = [_accountStore accountsWithAccountType:accountType];
    /*if (accounts.count == 0) {
     NSLog(@"Facebookアカウントが登録されていません");
     return;
     }
     */
    NSDictionary *options = @{ ACFacebookAppIdKey : _STFacebookAppID,
                               ACFacebookAudienceKey : ACFacebookAudienceOnlyMe,
                               ACFacebookPermissionsKey : @[@"email"] };
    
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook options:options completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                NSArray *accountsArray = [accountStore accountsWithAccountType:accountTypeFacebook];
                if (accountsArray.count > 0) {
                    
                    ACAccount *facebookAccount = [accountsArray objectAtIndex:0];
                    
                    NSString *fullname = [[facebookAccount valueForKey:@"properties"] objectForKey:@"fullname"];
                    
                    NSData *accountData = [fullname dataUsingEncoding:NSUTF8StringEncoding];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:accountData forKey:@"facebookName"];
                }
            } else {
                NSLog(@"User denied to access facebook account.");
            }
        });
    }];
}

@end
