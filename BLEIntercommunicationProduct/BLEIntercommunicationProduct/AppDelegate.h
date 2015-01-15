//
//  AppDelegate.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CBController.h"
#import "FirstViewController.h"
#import "TransferService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, CBControllerDelegate>{
    
    CBController    *cbController;
    FirstViewController  *viewController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSUUID *proximityUUID;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end