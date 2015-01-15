//
//  ScrollView.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/07.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewDelegate <NSObject>

-(void)touchedScrollView;

@end

@interface ScrollView : UIScrollView

@property (nonatomic, assign) id <ScrollViewDelegate> delegate;

@end