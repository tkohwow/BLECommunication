//
//  ViewController.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize viewSize = self.view.frame.size;
    
    //inputViewConを準備
    inputViewCon = [[InputViewController alloc]init];
    inputViewCon.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    scrollView = [[ScrollView alloc]initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(viewSize.width, 2500);
    [self.view addSubview:scrollView];
    
    nextPageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextPageButton.frame = CGRectMake(0, 0, 250, 100);
    nextPageButton.center = CGPointMake(viewSize.width / 2, 50);
    [nextPageButton setTitle:@"自分のプロフィールを編集" forState:UIControlStateNormal];
    [nextPageButton.titleLabel setFont:[UIFont fontWithName:@"AlNile-Bold" size:20]];
    [nextPageButton addTarget:self action:@selector(moveInputViewCon) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:nextPageButton];
    
    //説明ラベル
    HeadLabel *explainLabel = [[HeadLabel alloc]initWithFrame:CGRectMake(10, 80, viewSize.width - 20, viewSize.height * 0.2)];
    explainLabel.text = @"他の人のプロフィールが\n下のラベルに表示されます\n\nラベルをタップすると「連絡先」に\n登録することができます";
    [scrollView addSubview:explainLabel];
    
    // plistを読み込む
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"profile.plist"];
    NSArray *root = [NSArray arrayWithContentsOfFile:filePath];
    
    NSArray *profileArray[[root count]];
    
    CGRect rect[10];

    for (int i = 0; i < 10; i++) {
        
        rect[i] = CGRectMake(10, (explainLabel.frame.origin.y + explainLabel.frame.size.height) + (i * viewSize.height * 0.35), viewSize.width - 20, viewSize.height * 0.3);
        
        //受け取ったプロフィールを表示するViewを用意
        rpView[i] = [[ReceiveProfileView alloc]initWithFrame:rect[i]];
        rpView[i].delegate = self;
        rpView[i].tag = i;
        
        if (i <= ([root count] - 1) && [root count] != 0){
            
            profileArray[i] = [root objectAtIndex:([root count] - 1) - i];
            
            rpView[i].nameLabel.text = [profileArray[i] objectAtIndex:0];
            rpView[i].greetingLabel.text = [profileArray[i] objectAtIndex:1];
            rpView[i].profileLabel1.text = [profileArray[i] objectAtIndex:2];
            rpView[i].profileLabel2.text = [profileArray[i] objectAtIndex:3];
            rpView[i].profileLabel3.text = [profileArray[i] objectAtIndex:4];
            rpView[i].twitterNameLabel.text = [profileArray[i] objectAtIndex:5];
            rpView[i].facebookNameLabel.text = [profileArray[i] objectAtIndex:6];
            rpView[i].mailLabel.text = [profileArray[i] objectAtIndex:7];
        }
        
        [scrollView addSubview:rpView[i]];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)moveInputViewCon{
    
    [self presentViewController:inputViewCon animated:YES completion:nil];
}

- (void)touchedReceiveProfileView:(NSInteger)tag{

    // アドレス帳へのアクセスをユーザーに許可を求める（非同期）
    ABAddressBookRequestAccessWithCompletion(NULL, ^(bool granted, CFErrorRef error) { });
    
    ABRecordRef personRef = ABPersonCreate();
    ABUnknownPersonViewController *abupViewCon = [[ABUnknownPersonViewController alloc]init];
    
    CFErrorRef err = nil;
    
    //name
    ABRecordSetValue(personRef, kABPersonNicknameProperty, (__bridge CFStringRef)rpView[tag].nameLabel.text, &err);
    
    //greeting
    ABRecordSetValue(personRef, kABPersonNoteProperty, (__bridge CFStringRef)rpView[tag].greetingLabel.text, &err);
    
    //mail
    ABMutableMultiValueRef multiMail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiMail, (__bridge CFTypeRef)(rpView[tag].mailLabel.text),kABPersonPhoneMainLabel , NULL);
    ABRecordSetValue(personRef, kABPersonEmailProperty, multiMail, &err);
    CFRelease(multiMail);
    
    NSString *msg = [rpView[tag].nameLabel.text stringByAppendingString:@"さんを新規に連絡先に追加する場合は、Create New Contactを選んで下さい。"];
    
    abupViewCon.message = [NSString stringWithFormat:msg,rpView[tag].nameLabel.text];
    abupViewCon.displayedPerson = personRef;
    abupViewCon.allowsActions = NO;
    abupViewCon.allowsAddingToAddressBook = YES;
    abupViewCon.unknownPersonViewDelegate = self;
    
    profileNaviCon = [[UINavigationController alloc]initWithRootViewController:abupViewCon];
    
    abupViewCon.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
                                             action:@selector(dismissContactView)];
    
    [self presentViewController:profileNaviCon animated:YES completion:nil];
    
    CFRelease(personRef);
}

- (void)dismissContactView{
    
    [profileNaviCon dismissViewControllerAnimated:YES completion:nil];
}

//連絡先の操作を終えた時
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController didResolveToPerson:(ABRecordRef)person{
    
    [self performSelector:@selector(dismissContactView) withObject:nil afterDelay:0.5];
}

- (void)addProfileLabel{
    
    // plistを読み込む
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"profile.plist"];
    NSArray *newArray = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSArray *ivArray[[newArray count]];
    for (int i = 0; i < [newArray count]; i++) {
        
        ivArray[i] = [newArray objectAtIndex:([newArray count] - 1) - i];
        rpView[i].nameLabel.text = [ivArray[i] objectAtIndex:0];
        rpView[i].greetingLabel.text = [ivArray[i] objectAtIndex:1];
        rpView[i].profileLabel1.text = [ivArray[i] objectAtIndex:2];
        rpView[i].profileLabel2.text = [ivArray[i] objectAtIndex:3];
        rpView[i].profileLabel3.text = [ivArray[i] objectAtIndex:4];
        rpView[i].twitterNameLabel.text = [ivArray[i] objectAtIndex:5];
        rpView[i].facebookNameLabel.text = [ivArray[i] objectAtIndex:6];
        rpView[i].mailLabel.text = [ivArray[i] objectAtIndex:7];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end