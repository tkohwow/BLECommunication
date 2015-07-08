//
//  ViewController.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TransferService.h"
#import "ReceiveProfileView.h"
#import "InputViewController.h"
#import "HeadLabel.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate,ABUnknownPersonViewControllerDelegate, UINavigationControllerDelegate,ReceiveProfileViewDelegate>
{
    UIScrollView        *scrollView;
    
    ReceiveProfileView  *rpView[10];
    
    HeadLabel           *nameLabel;
    HeadLabel           *profileLabel;
    HeadLabel           *sexLabel;
    UIButton            *nextPageButton;
    NSData              *dataToSend[4];
    
    InputViewController     *inputViewCon;
    UINavigationController  *profileNaviCon;
}

- (void)addProfileLabel;

@end