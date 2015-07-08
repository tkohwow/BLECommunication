//
//  AppDelegate.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/04.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //通知を許可するかどうかの通知が表示される
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //Beaconによる領域観測が可能であるかチェック
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        
        //CLLocationManagerの生成とデリゲートの設定
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        // 生成したUUIDからNSUUIDを作成
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:BEACON_PROXIMITY_UUID];
        //identifierを作成
        NSString *identifier = @"beaconIdentifier";
        // CLBeaconRegionを作成
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID identifier:identifier];
        
        self.beaconRegion.notifyOnEntry = YES;
        self.beaconRegion.notifyOnExit = YES;
        self.beaconRegion.notifyEntryStateOnDisplay = NO;
        
        // Beaconによる領域観測を開始
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
    
    cbController = [[CBController alloc] init];
    cbController.delegate = self;
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    viewController = [[FirstViewController alloc]init];
    [self.window addSubview:viewController.view];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.beaconRegion];
}

// Beaconとの状態が確定したときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside://既に領域内にいた場合
            NSLog(@"CLRegionStateInside");
            break;
        case CLRegionStateOutside:
            NSLog(@"CLRegionStateOutside");
            break;
        case CLRegionStateUnknown:
            NSLog(@"CLRegionStateUnknown");
            break;
        default:
            break;
    }
}

//領域に入った
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if (cbController == nil) {
        cbController = [[CBController alloc] init];
        cbController.delegate = self;
        
        //[self nofityMessage:[NSArray arrayWithObjects:@"cbController",@"起動！", nil]];
    }
    
    [cbController startCentralManager];
    //[self nofityMessage:[NSArray arrayWithObjects:@"セントラル",@"起動！", nil]];
    
    // Beaconの距離測定を開始する（しなくてもよい）
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

//領域から出た
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [cbController stopAdvertising];
    
    //[self nofityMessage:[NSArray arrayWithObjects:@"ペリフェラル",@"終了！", nil]];
    
    // Beaconの距離測定を終了する（しなくてもよい）
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

/*
 - (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
 {
 if (beacons.count > 0) {
 // 最も距離の近いBeaconについて処理する。beacon配列は距離が近い順にソートされている
 CLBeacon *nearestBeacon = beacons.firstObject;
 
 NSString *rangeMessage;
 
 // Beacon の距離でメッセージを変える
 switch (nearestBeacon.proximity) {
 case CLProximityImmediate:
 rangeMessage = @"Range Immediate: ";
 break;
 case CLProximityNear:
 rangeMessage = @"Range Near: ";
 break;
 case CLProximityFar:
 rangeMessage = @"Range Far: ";
 break;
 default:
 rangeMessage = @"Range Unknown: ";
 break;
 }
 
 }
 */

- (void)nofityMessage:(NSArray*)profileArray{
    
    // 通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [[NSDate date] init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = [NSString stringWithFormat:@"%@\n%@",[profileArray objectAtIndex:0],[profileArray objectAtIndex:1]];
    notification.alertAction = @"Open";
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

- (void)addProfile{
    
    [viewController addProfileLabel];
}

@end
