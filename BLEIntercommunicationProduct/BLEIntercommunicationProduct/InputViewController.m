//
//  InputViewController.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/06.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults dataForKey:@"name"] length] == 0) {
        nameString = @"入力なし";
    }else{
        nameString = [[NSString alloc]initWithData:[userDefaults dataForKey:@"name"] encoding:NSUTF8StringEncoding];
    }
    if ([[userDefaults dataForKey:@"greeting"] length] == 0) {
        greetingString = @"入力なし";
    }else{
        greetingString = [[NSString alloc]initWithData:[userDefaults dataForKey:@"greeting"] encoding:NSUTF8StringEncoding];
    }
    if ([[userDefaults dataForKey:@"profile1"] length] == 0) {
        profileString[0] = @"入力なし";
    }else{
        profileString[0] = [[NSString alloc]initWithData:[userDefaults dataForKey:@"profile1"] encoding:NSUTF8StringEncoding];
    }
    if ([[userDefaults dataForKey:@"profile2"] length] == 0) {
        profileString[1] = @"入力なし";
    }else{
        profileString[1] = [[NSString alloc]initWithData:[userDefaults dataForKey:@"profile2"] encoding:NSUTF8StringEncoding];
    }
    if ([[userDefaults dataForKey:@"profile3"] length] == 0) {
        profileString[2] = @"入力なし";
    }else{
        profileString[2] = [[NSString alloc]initWithData:[userDefaults dataForKey:@"profile3"] encoding:NSUTF8StringEncoding];
    }
    if ([[userDefaults dataForKey:@"mail"] length] == 0) {
        mailString = @"入力なし";
    }else{
        mailString = [[NSString alloc]initWithData:[userDefaults dataForKey:@"mail"] encoding:NSUTF8StringEncoding];
    }
    
    CGSize viewSize = self.view.frame.size;
    
    scrollView = [[ScrollView alloc]initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(viewSize.width, viewSize.height * 1.7);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    [self initLabelAndTextFild];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(0, 0, 150, 100);
    backButton.center = CGPointMake(self.view.center.x, scrollView.contentSize.height - 50);
    [backButton setTitle:@"編集完了" forState:UIControlStateNormal];
    //[backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"AlNile-Bold" size:20]];
    [backButton addTarget:self action:@selector(pushedBackButton) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:backButton];
    
    /*ラジオボタン
     NSArray *sexArray = [NSArray arrayWithObjects:@"男性",@"女性", nil];
     UISegmentedControl *sexSegment = [[UISegmentedControl alloc]initWithItems:sexArray];
     sexSegment.frame = rightSide3;
     
     NSString *judgeSex = [[NSString alloc] initWithData:[userDefaults dataForKey:@"sex"]  encoding:NSUTF8StringEncoding];
     
     if ([judgeSex isEqualToString:@"男"]) {
     sexSegment.selectedSegmentIndex = 0;
     }
     else if ([judgeSex isEqualToString:@"女"]) {
     sexSegment.selectedSegmentIndex = 1;
     }
     
     [sexSegment addTarget:self action:@selector(sexSegPushed:) forControlEvents:UIControlEventValueChanged];
     [scrollView addSubview:sexSegment];
     */
}

- (void)viewWillAppear:(BOOL)animated{
    
    scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)initLabelAndTextFild{
    
    CGSize viewSize = self.view.frame.size;
    
    float betweenLeftEdge = viewSize.width * 0.05;
    float betweenUpperEdge = viewSize.height * 0.05;
    float betweenLeftEdgeAndRigthLabel = viewSize.width * 0.35;
    float basicLabelHeight = viewSize.height * 0.075;
    float basicLeftSideWidth = viewSize.width * 0.2;
    float basicRightSideWidth = viewSize.width * 0.6;
    
    CGRect leftSide1 = CGRectMake(betweenLeftEdge, viewSize.height * 0.1, basicLeftSideWidth, basicLabelHeight);
    CGRect rightSide1 = CGRectMake(betweenLeftEdgeAndRigthLabel, viewSize.height * 0.1, basicRightSideWidth, basicLabelHeight);
    
    CGRect leftSide2 = CGRectMake(betweenLeftEdge, (leftSide1.origin.y + leftSide1.size.height) + betweenUpperEdge, basicLeftSideWidth, viewSize.height * 0.2);
    CGRect leftSide3 = CGRectMake(betweenLeftEdge, (leftSide2.origin.y + leftSide2.size.height) + betweenUpperEdge * 2, basicLeftSideWidth, basicLabelHeight * 3 + betweenUpperEdge * 2);
    CGRect leftSide4 = CGRectMake(betweenLeftEdge, (leftSide3.origin.y + leftSide3.size.height) + betweenUpperEdge * 2, basicLeftSideWidth, basicLabelHeight);
    CGRect leftSide5 = CGRectMake(betweenLeftEdge, (leftSide4.origin.y + leftSide4.size.height) + betweenUpperEdge * 2, basicLeftSideWidth, basicLabelHeight);
    CGRect leftSide6 = CGRectMake(betweenLeftEdge, (leftSide5.origin.y + leftSide5.size.height) + betweenUpperEdge * 2, basicLeftSideWidth, basicLabelHeight);
    
    CGRect rightSide2 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide1.origin.y + rightSide1.size.height) + betweenUpperEdge, basicRightSideWidth, viewSize.height * 0.2);
    CGRect rightSide3 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide2.origin.y + rightSide2.size.height) + betweenUpperEdge * 2, basicRightSideWidth, basicLabelHeight);
    CGRect rightSide4 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide3.origin.y + rightSide3.size.height) + betweenUpperEdge, basicRightSideWidth, basicLabelHeight);
    CGRect rightSide5 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide4.origin.y + rightSide4.size.height) + betweenUpperEdge, basicRightSideWidth, basicLabelHeight);
    CGRect rightSide6 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide5.origin.y + rightSide5.size.height) + betweenUpperEdge * 2, basicRightSideWidth, basicLabelHeight);
    CGRect rightSide7 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide6.origin.y + rightSide6.size.height) + betweenUpperEdge * 2, basicRightSideWidth, basicLabelHeight);
    CGRect rightSide8 = CGRectMake(betweenLeftEdgeAndRigthLabel, (rightSide7.origin.y + rightSide7.size.height) + betweenUpperEdge * 2, basicRightSideWidth, basicLabelHeight);
    
    //left1
    HeadLabel *nameLabel = [[HeadLabel alloc]initWithFrame:leftSide1];
    nameLabel.text = @"名前";
    [scrollView addSubview:nameLabel];
    
    //left2
    HeadLabel *greetingLabel = [[HeadLabel alloc]initWithFrame:leftSide2];
    greetingLabel.text = @"あいさつ";
    [scrollView addSubview:greetingLabel];
    
    //left3
    HeadLabel *sexLabel = [[HeadLabel alloc]initWithFrame:leftSide3];
    sexLabel.text = @"興味・\n\n趣味・\n\n悩み\n\n等";
    [scrollView addSubview:sexLabel];
    
    //left4
    HeadLabel *twitterLabel = [[HeadLabel alloc]initWithFrame:leftSide4];
    twitterLabel.text = @"Twitter\nID";
    [scrollView addSubview:twitterLabel];
    
    //left5
    HeadLabel *facebookLabel = [[HeadLabel alloc]initWithFrame:leftSide5];
    facebookLabel.text = @"Facebook\n表示名";
    [scrollView addSubview:facebookLabel];
    
    //left6
    HeadLabel *mailLabel = [[HeadLabel alloc]initWithFrame:leftSide6];
    mailLabel.text = @"メールアドレス";
    [scrollView addSubview:mailLabel];
    
    //right1(name)
    TemplateTextField *nameTextField = [[TemplateTextField alloc]initWithFrame:rightSide1];
    nameTextField.delegate = self;
    nameTextField.tag = 2;
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"name"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        nameTextField.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"name"]  encoding:NSUTF8StringEncoding];}
    [scrollView addSubview:nameTextField];
    
    //right2（52文字）(profile)
    UITextView *greetingTextView;
    greetingTextView = [[UITextView alloc]initWithFrame:rightSide2];
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"greeting"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        greetingTextView.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"greeting"]  encoding:NSUTF8StringEncoding];}
    greetingTextView.delegate = self;
    greetingTextView.editable = YES;
    greetingTextView.tag = 3;
    greetingTextView.returnKeyType = UIReturnKeyDone;
    greetingTextView.layer.borderWidth = 0.5f;//枠線の幅
    greetingTextView.layer.cornerRadius = 5.0f;//角の丸み
    greetingTextView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;//枠線の色
    [scrollView addSubview:greetingTextView];
    
    //right3
    TemplateTextField *profileTextFiedl1 = [[TemplateTextField alloc]initWithFrame:rightSide3];
    profileTextFiedl1.delegate = self;
    profileTextFiedl1.tag = 4;
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"profile1"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        profileTextFiedl1.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"profile1"]  encoding:NSUTF8StringEncoding];}
    [scrollView addSubview:profileTextFiedl1];
    
    //right4
    TemplateTextField *profileTextFiedl2 = [[TemplateTextField alloc]initWithFrame:rightSide4];
    profileTextFiedl2.delegate = self;
    profileTextFiedl2.tag = 5;
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"profile2"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        profileTextFiedl2.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"profile2"]  encoding:NSUTF8StringEncoding];}
    [scrollView addSubview:profileTextFiedl2];

    //right5
    TemplateTextField *profileTextFiedl3 = [[TemplateTextField alloc]initWithFrame:rightSide5];
    profileTextFiedl3.delegate = self;
    profileTextFiedl3.tag = 6;
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"profile3"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        profileTextFiedl3.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"profile3"]  encoding:NSUTF8StringEncoding];}
    [scrollView addSubview:profileTextFiedl3];
    
    //right6
    twitterIDLabel = [[SocialLabel alloc]initWithFrame:rightSide6];
    twitterIDLabel.delegate = self;
    twitterIDLabel.tag = 1;
    twitterIDLabel.backgroundColor = [UIColor greenColor];
    twitterIDLabel.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"twitter"]  encoding:NSUTF8StringEncoding];
    [scrollView addSubview:twitterIDLabel];
    
    //right7
    facebookIDLabel = [[SocialLabel alloc]initWithFrame:rightSide7];
    facebookIDLabel.delegate = self;
    facebookIDLabel.tag = 2;
    facebookIDLabel.backgroundColor = [UIColor greenColor];
    facebookIDLabel.text = [[NSString alloc]initWithData:[userDefaults dataForKey:@"facebook"] encoding:NSUTF8StringEncoding];
    [scrollView addSubview:facebookIDLabel];
    
    //right8
    TemplateTextField *mailTextField = [[TemplateTextField alloc]initWithFrame:rightSide8];
    mailTextField.delegate = self;
    mailTextField.tag = 7;
    if (![[[NSString alloc] initWithData:[userDefaults dataForKey:@"mail"]  encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]) {
        mailTextField.text = [[NSString alloc] initWithData:[userDefaults dataForKey:@"mail"]  encoding:NSUTF8StringEncoding];}
    [scrollView addSubview:mailTextField];
    
    //スイッチ
    float switchX = rightSide1.origin.x + rightSide1.size.width - betweenUpperEdge;
    
    UISwitch *permitSwitch1 = [[UISwitch alloc]init];
    permitSwitch1.tag = 1;
    permitSwitch1.center = CGPointMake(switchX, rightSide6.origin.y + rightSide6.size.height + betweenUpperEdge);
    [permitSwitch1 addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:permitSwitch1];
    
    UISwitch *permitSwitch2 = [[UISwitch alloc]init];
    permitSwitch2.tag = 2;
    permitSwitch2.center = CGPointMake(switchX, rightSide7.origin.y + rightSide7.size.height + betweenUpperEdge);
    [permitSwitch2 addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:permitSwitch2];
    
    UISwitch *permitSwitch3 = [[UISwitch alloc]init];
    permitSwitch3.tag = 3;
    permitSwitch3.center = CGPointMake(switchX, rightSide8.origin.y + rightSide8.size.height + betweenUpperEdge);
    [permitSwitch3 addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:permitSwitch3];
    
    
    //文字数制限ラベル
    CGRect limit1 = CGRectMake(betweenLeftEdgeAndRigthLabel + basicRightSideWidth / 2, rightSide1.origin.y + rightSide1.size.height, basicRightSideWidth / 2, betweenUpperEdge);
    CGRect limit2 = CGRectMake(limit1.origin.x, rightSide2.origin.y + rightSide2.size.height,limit1.size.width, limit1.size.height);
    CGRect limit3 = CGRectMake(limit1.origin.x, rightSide3.origin.y + rightSide3.size.height,limit1.size.width, limit1.size.height);
    CGRect limit4 = CGRectMake(limit1.origin.x, rightSide4.origin.y + rightSide4.size.height,limit1.size.width, limit1.size.height);
    CGRect limit5 = CGRectMake(limit1.origin.x, rightSide5.origin.y + rightSide5.size.height,limit1.size.width, limit1.size.height);
    
    HeadLabel *limitLabel1 = [[HeadLabel alloc]initWithFrame:limit1];
    limitLabel1.text = @"※10文字まで";
    [scrollView addSubview:limitLabel1];
    
    HeadLabel *limitLabel2 = [[HeadLabel alloc]initWithFrame:limit2];
    limitLabel2.text = @"※30文字まで";
    [scrollView addSubview:limitLabel2];
    
    HeadLabel *limitLabel3 = [[HeadLabel alloc]initWithFrame:limit3];
    limitLabel3.text = @"※15文字まで";
    [scrollView addSubview:limitLabel3];
    
    HeadLabel *limitLabel4 = [[HeadLabel alloc]initWithFrame:limit4];
    limitLabel4.text = @"※15文字まで";
    [scrollView addSubview:limitLabel4];
    
    HeadLabel *limitLabel5 = [[HeadLabel alloc]initWithFrame:limit5];
    limitLabel5.text = @"※15文字まで";
    [scrollView addSubview:limitLabel5];
    
    //必須！ラベル
    CGRect required1 = CGRectMake(betweenLeftEdgeAndRigthLabel, limit1.origin.y, limit1.size.width, limit1.size.height);
    CGRect required2 = CGRectMake(betweenLeftEdgeAndRigthLabel, limit2.origin.y, limit2.size.width, limit2.size.height);
    
    HeadLabel *requiredLabel1 = [[HeadLabel alloc]initWithFrame:required1];
    HeadLabel *requiredLabel2 = [[HeadLabel alloc]initWithFrame:required2];
    requiredLabel1.text = @"必須！";
    requiredLabel2.text = @"必須！";
    requiredLabel1.textColor = [UIColor redColor];
    requiredLabel2.textColor = [UIColor redColor];
    requiredLabel1.textAlignment = NSTextAlignmentRight;
    requiredLabel2.textAlignment = NSTextAlignmentRight;
    [scrollView addSubview:requiredLabel1];
    [scrollView addSubview:requiredLabel2];
}

//テキストフィールド内が変化した時(UITextField)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@","]) {
        return NO;
    }
    
    if (textField.tag == 2) {
        
        //最大入力文字数
        int maxInputLength = 10;
        
        //入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        //入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        //最大文字数を超えていた時
        if ([str length] > maxInputLength) {
            
            //YESを返せば直前の入力がUITextFieldに反映されるが、NOを返した場合は反映されない
            return NO;
        }
    }
    
    if (textField.tag == 4) {
        
        //最大入力文字数
        int maxInputLength = 15;
        
        //入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        //入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        //最大文字数を超えていた時
        if ([str length] > maxInputLength) {
            
            //YESを返せば直前の入力がUITextFieldに反映されるが、NOを返した場合は反映されない
            return NO;
        }
    }
    
    if (textField.tag == 5) {
        
        //最大入力文字数
        int maxInputLength = 15;
        
        //入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        //入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        //最大文字数を超えていた時
        if ([str length] > maxInputLength) {
            
            //YESを返せば直前の入力がUITextFieldに反映されるが、NOを返した場合は反映されない
            return NO;
        }
    }
    
    if (textField.tag == 6) {
        
        //最大入力文字数
        int maxInputLength = 15;
        
        //入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        //入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        //最大文字数を超えていた時
        if ([str length] > maxInputLength) {
            
            //YESを返せば直前の入力がUITextFieldに反映されるが、NOを返した場合は反映されない
            return NO;
        }
    }
    
    if (textField.tag == 7) {
        
        //最大入力文字数
        int maxInputLength = 20;
        
        //入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        //入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        //最大文字数を超えていた時
        if ([str length] > maxInputLength) {
            
            //YESを返せば直前の入力がUITextFieldに反映されるが、NOを返した場合は反映されない
            return NO;
        }
    }
    
    return YES;
}

//キーボードのReturnをおした時(UITextField)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //キーボード画面をクローズします。
    [textField resignFirstResponder];
    return NO;
}

//テキストフィールドの編集が終了する直後に呼び出される(UITextField)
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 2) {
        nameString = textField.text;
    }
    if (textField.tag == 4) {
        profileString[0] = textField.text;
    }
    if (textField.tag == 5) {
        profileString[1] = textField.text;
    }
    if (textField.tag == 6) {
        profileString[2] = textField.text;
    }
    if (textField.tag == 7) {
        mailString = textField.text;
    }
}

//テキストビューに入力があった時（UITextView）
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@","]) {
        return NO;
    }
    
    //リターンキーが押された
    if ([text isEqualToString:@"\n"]) {
        
        // キーボードを閉じる
        [textView resignFirstResponder];
        return NO;
    }
    
    //最大入力文字数
    int maxInputLength = 30;
    
    //入力済みのテキストを取得
    NSMutableString *str = [textView.text mutableCopy];
    
    //入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:text];
    
    //最大文字数を超えていた時
    if ([str length] > maxInputLength) {
        
        //YESを返せば直前の入力がUITextViewに反映されるが、NOを返した場合は反映されない
        return NO;
    }
    
    return YES;
}



//テキストビューの編集が終了した時（UITextView）
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    greetingString = textView.text;
}

//性別のセグメントが押された時
/*
- (void)sexSegPushed:(UISegmentedControl*)buttons{
    
    switch (buttons.selectedSegmentIndex) {
        case 0:
            
            [self saveData:@"男" saveMode:3];
            break;
        case 1:
            
            [self saveData:@"女" saveMode:3];
            break;
            
        default:
            break;
    }
    
    
}
 */

//スクロールビューが押された時
-(void)touchedScrollView{
    
    //[profileTextView resignFirstResponder];
}

//ソーシャルラベルが押された時
- (void)touchedHeadLabel:(NSInteger)tag{
    
    if (tag == 1) {
    
        SocialAccountsController *saController = [[SocialAccountsController alloc]init];
        
        [saController getTwitterAccount];
        
        twitterIDLabel.text = [[NSString alloc]initWithData:[userDefaults dataForKey:@"twitterName"] encoding:NSUTF8StringEncoding];
    }
    else if (tag == 2){
        
        SocialAccountsController *saController = [[SocialAccountsController alloc]init];
        
        [saController getFacebookAccount];
        
        facebookIDLabel.text = [[NSString alloc]initWithData:[userDefaults dataForKey:@"facebookName"] encoding:NSUTF8StringEncoding];
    }
}

//スイッチが押された時
- (void)changeSwitch:(UISwitch*)sw{
    
    if (sw.tag == 1) {
        if (sw.on) {
            permitStwitch[0] = @"1";
        }else{
            permitStwitch[0] = @"0";
        }
    }
    if (sw.tag == 2) {
        if (sw.on) {
            permitStwitch[1] = @"1";
        }else{
            permitStwitch[1] = @"0";
        }
    }
    if (sw.tag == 3) {
        if (sw.on) {
            permitStwitch[2] = @"1";
        }else{
            permitStwitch[2] = @"0";
        }
    }
}

//バックボタンが押された時
- (void)pushedBackButton{
    
    if ([nameString length] == 0) {
        nameString = @"入力なし";
    }
    if ([greetingString length] == 0) {
        greetingString = @"入力なし";
    }
    if ([profileString[0] length] == 0) {
        profileString[0] = @"入力なし";
    }
    if ([profileString[1] length] == 0) {
        profileString[1] = @"入力なし";
    }
    if ([profileString[2] length] == 0) {
        profileString[2] = @"入力なし";
    }
    if ([mailString length] == 0) {
        mailString = @"入力なし";
    }
    
    [userDefaults setObject:[nameString dataUsingEncoding:NSUTF8StringEncoding] forKey:@"name"];
    [userDefaults setObject:[greetingString dataUsingEncoding:NSUTF8StringEncoding] forKey:@"greeting"];
    [userDefaults setObject:[profileString[0] dataUsingEncoding:NSUTF8StringEncoding] forKey:@"profile1"];
    [userDefaults setObject:[profileString[1] dataUsingEncoding:NSUTF8StringEncoding] forKey:@"profile2"];
    [userDefaults setObject:[profileString[2] dataUsingEncoding:NSUTF8StringEncoding] forKey:@"profile3"];
    [userDefaults setObject:[profileString[2] dataUsingEncoding:NSUTF8StringEncoding] forKey:@"mail"];
    
    //0は拒否、1は許可
    NSData *switchData[3];
    for (int i = 0; i < 3; i++) {
        if ([permitStwitch[i] length] == 0) {//入力なしだったら0を入れる
            permitStwitch[i] = @"0";
        }
        switchData[i] = [permitStwitch[i] dataUsingEncoding:NSUTF8StringEncoding];

        [userDefaults setObject:switchData[i] forKey:[NSString stringWithFormat:@"switch[%i]",i]];
        
        //NSLog(@"%i = %@",i,[[NSString alloc] initWithData: [userDefaults objectForKey:[NSString stringWithFormat:@"switch[%i]",i]] encoding:NSUTF8StringEncoding]);
    }
    
    NSString *twitterNameString;
    NSString *facebookNameString;
    
    if ([[userDefaults dataForKey:@"twitterName"] length] != 0) {
        twitterNameString = [[NSString alloc]initWithData:[userDefaults dataForKey:@"twitterName"] encoding:NSUTF8StringEncoding];
    }else{
        twitterNameString = @"なし";
    }
    
    if ([[userDefaults dataForKey:@"facebookName"] length] != 0) {
        facebookNameString = [[NSString alloc]initWithData:[userDefaults dataForKey:@"facebookName"] encoding:NSUTF8StringEncoding];
    }else{
        facebookNameString = @"なし";
    }
    
    NSString *unionString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",nameString, greetingString, profileString[0], profileString[1], profileString[2], twitterNameString, facebookNameString, mailString, permitStwitch[0], permitStwitch[1], permitStwitch[2]];
    //0,名前　1,挨拶　2,プロフィール１　3,プロフィール２　4,プロフィール３　5,twitterID　6,facebookName　7,メールアドレス　8,twitterOn/Off 9,facebookOn/Off 10,mailOn/Off
    
    NSString *chara1String = [NSString stringWithFormat:@"%@,%@",nameString, greetingString];
    NSString *chara2String = [NSString stringWithFormat:@"%@,%@,%@",profileString[0],profileString[1],profileString[2]];
    NSString *chara3String = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",twitterNameString,facebookNameString,mailString,permitStwitch[0],permitStwitch[1],permitStwitch[2]];
    
    NSData *unionData = [unionString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *chara1Data = [chara1String dataUsingEncoding:NSUTF8StringEncoding];
    NSData *chara2Data = [chara2String dataUsingEncoding:NSUTF8StringEncoding];
    NSData *chara3Data = [chara3String dataUsingEncoding:NSUTF8StringEncoding];
    
    [userDefaults setObject:unionData forKey:@"union"];
    [userDefaults setObject:chara1Data forKey:@"chara1"];
    [userDefaults setObject:chara2Data forKey:@"chara2"];
    [userDefaults setObject:chara3Data forKey:@"chara3"];
    
    [userDefaults synchronize];
    
    NSLog(@"%@",unionString);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
