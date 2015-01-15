//
//  CBController.h
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/18.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TransferService.h"

@protocol CBControllerDelegate <NSObject>

- (void)nofityMessage:(NSArray*)messageArray;
- (void)addProfile;

@end

@interface CBController : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate>{
    
    CBUUID              *serviceUUID;
    CBUUID              *characteristicUUID[3];
    
    CBPeripheral        *discoveredPeriperal[10];
    
    NSMutableArray      *mUnionArray[10];
    NSMutableArray      *peripheralArray;
    
    NSString            *inputMessage;
    
    BOOL                discoverPeripheral;
    int                 discoverNum;
}

@property (nonatomic, assign) id <CBControllerDelegate> delegate;

@property (strong, nonatomic) CBCentralManager          *centralManager;
@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *characteristic1;
@property (strong, nonatomic) CBMutableCharacteristic   *characteristic2;
@property (strong, nonatomic) CBMutableCharacteristic   *characteristic3;

-(void)startCentralManager;
- (void)stopAdvertisingAndScan;

@end
