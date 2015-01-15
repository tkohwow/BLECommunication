//
//  CBController.m
//  BLEIntercommunicationProduct
//
//  Created by TakeoMatsumoto on 2014/11/18.
//  Copyright (c) 2014年 Matsumoto Takeo. All rights reserved.
//

#import "CBController.h"

@implementation CBController

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        //サービスと特性のUUIDをセット
        serviceUUID = [CBUUID UUIDWithString:TRANSFER_SERVICE_UUID];
        characteristicUUID[0] = [CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_VALUE1];
        characteristicUUID[1] = [CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_VALUE2];
        characteristicUUID[2] = [CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_VALUE3];
        
        //サービスUUIDに対して可変の特性を生成
        self.characteristic1 = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID[0] properties:(CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead) value:nil permissions:(CBAttributePermissionsWriteable | CBAttributePermissionsReadable)];
        //サービスUUIDに対して可変の特性を生成(２つ目)
        self.characteristic2 = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID[1] properties:(CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead) value:nil permissions:(CBAttributePermissionsWriteable | CBAttributePermissionsReadable)];
        //サービスUUIDに対して可変の特性を生成(３つ目)
        self.characteristic3 = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID[2] properties:(CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead) value:nil permissions:(CBAttributePermissionsWriteable | CBAttributePermissionsReadable)];
    }
    
    return self;
}

- (void)startCentralManager{
    
    discoverPeripheral = NO;
    discoverNum = 0;
    
    //見つけたPeripheralを入れておくArray
    peripheralArray = [NSMutableArray array];
    
    if (_centralManager == nil) {
        //CentralManagerを初期化生成
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }else{
        [self centralManagerDidUpdateState:_centralManager];
    }
}

- (void)preInitPM{
    
    if (!discoverPeripheral) {
        [self startPeripheralManager];
        [self.centralManager stopScan];
    }
}

- (void)startPeripheralManager{
    
    discoverPeripheral = NO;
    
    if (_peripheralManager == nil) {
        //PeripheralManagerを初期化生成
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    }else{
        [self peripheralManagerDidUpdateState:_peripheralManager];
    }
}

- (void)stopAdvertisingAndScan{
    
    [self.centralManager stopScan];
    [self.peripheralManager stopAdvertising];
}

//CentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentralCentral

//CentralManagerを生成した際とステートが更新された際に呼ばれる
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    //アドバタイズしているペリフェラルを検出する
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO}];
    
    [self performSelector:@selector(preInitPM) withObject:nil afterDelay:2];
}

//ペリフェラルが見つかったらそれぞれ呼ばれる
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    discoverPeripheral = YES;
    
    //NSLog(@"Discovered %@", peripheral.name);
    
    discoveredPeriperal[discoverNum] = peripheral;
    
    //接続を要求
    [self.centralManager connectPeripheral:peripheral options:nil];
    
    //接続先のペリフェラルが見つかったら省電力のためスキャンを停止
    //[self.centralManager stopScan];
    
    //受け取ったデータを入れるMutableArrayをペリフェラルの数だけ用意
    mUnionArray[discoverNum] = [NSMutableArray array];
    
    discoverNum ++;
}

//接続に成功したら呼ばれる
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
    //ベリフェラルのデリゲートをselfに。イベントに応じ、コールバックとしてそのメソッドが呼ばれるようになる。
    peripheral.delegate = self;
    
    //ベリフェラルが提供するサービスのリストを取得
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}

//該当するサービスが見つかると呼ばれる
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    //検出したサービスの配列にアクセス
    for (CBMutableService *service in peripheral.services) {
        
        //サービスの特性を検出
        [peripheral discoverCharacteristics:@[characteristicUUID[0],characteristicUUID[1],characteristicUUID[2]] forService:service];
    }
}

//サービスの特性を検出すると呼ばれる
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    //検出した特性
    for (CBMutableCharacteristic *characteristic in service.characteristics) {
        
        if ([characteristic.UUID isEqual:characteristicUUID[0]]) {
            
            //読み込み要求
            [peripheral readValueForCharacteristic:characteristic];
            
        }
        
        if ([characteristic.UUID isEqual:characteristicUUID[1]]) {
            
            //読み込み要求
            [peripheral readValueForCharacteristic:characteristic];
            
        }
        if ([characteristic.UUID isEqual:characteristicUUID[2]]) {
            
            //読み込み要求
            [peripheral readValueForCharacteristic:characteristic];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            //書き込み要求
            if ([[userDefaults dataForKey:@"union"] length] != 0) {
                [peripheral writeValue:[userDefaults dataForKey:@"union"] forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            }else{
                [peripheral writeValue:[@"入力なし,入力なし,入力なし,入力なし,入力なし,なし,なし,入力なし,0,0,0" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            }
            
        }
    }
}

//値の読み取りが終了すると呼ばれる
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //値が変化してもその都度通知しない
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
    
    //データ幅が156を超えるとまずいっぽい
    NSString *res = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    NSLog(@"res = %i",[res length]);
    
    //ペリフェラルごとにmUnionArrayを分ける
    NSUInteger index = [peripheralArray indexOfObject:peripheral];
    
    if (index == NSNotFound) {
        
        index = [peripheralArray count];
        [peripheralArray addObject:peripheral];
        
    }
    
    if ([characteristic.UUID isEqual:characteristicUUID[0]]){
        
        //受け取ったデータを項目ごとに分けてArrayに保存
        NSArray *stringArray = [res componentsSeparatedByString:@","];
        
        for (NSString *s in stringArray) {
            [mUnionArray[index] addObject:s];
        }
    }
    else if ([characteristic.UUID isEqual:characteristicUUID[1]]){
        
        //受け取ったデータを項目ごとに分けてArrayに保存
        NSArray *stringArray = [res componentsSeparatedByString:@","];
        
        for (NSString *s in stringArray) {
            [mUnionArray[index] addObject:s];
        }
    }
    else if ([characteristic.UUID isEqual:characteristicUUID[2]]){
        
        //受け取ったデータを項目ごとに分けてArrayに保存
        NSArray *stringArray = [res componentsSeparatedByString:@","];
        
        for (NSString *s in stringArray) {
            [mUnionArray[index] addObject:s];
        }
        
        //mutableArrayをArrayに
        NSArray *unionArray = [mUnionArray[index] copy];
        
        //データを投げる
        [self ReceiveProfile:unionArray];
        
        NSLog(@"ind = %lu dis = %i",(unsigned long)index,discoverNum);
        
        if (index == discoverNum) {
            
            [self startPeripheralManager];
            [self.centralManager stopScan];
            [peripheralArray removeAllObjects];
        }
    }
}

//書き込み後呼び出される
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    
    //書き込みエラー
    if (error) {
    }
}

//PeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheralPeripheral

//生成された後と、ステートが変わった時に呼び出し
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    
    
    //サービスUUIDに関連付ける可変のサービスを生成
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    //生成したサービスに特性を対応づけ
    transferService.characteristics = @[self.characteristic1,self.characteristic2, self.characteristic3];
    
    
    //デバイスのサービス/特性データベースに登録
    [self.peripheralManager addService:transferService];
}

//サービスを公開すると呼ばれる
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    
    //セントラルに対してアドバタイズする
    [self.peripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[serviceUUID]}];
}

//アドバタイズを始めると呼ばれる
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    
}

//読み取り要求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([request.characteristic.UUID isEqual:characteristicUUID[0]]) {
        
        if ([[userDefaults dataForKey:@"chara1"] length] != 0) {
            request.value = [userDefaults dataForKey:@"chara1"];
        }else{
            request.value = [@"入力なし,入力なし" dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
    
    if ([request.characteristic.UUID isEqual:characteristicUUID[1]]) {
    
        if ([[userDefaults dataForKey:@"chara2"] length] != 0) {
            request.value = [userDefaults dataForKey:@"chara2"];
        }else{
            request.value = [@"入力なし,入力なし,入力なし" dataUsingEncoding:NSUTF8StringEncoding];
        }
        [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
    if ([request.characteristic.UUID isEqual:characteristicUUID[2]]) {
        if ([[userDefaults dataForKey:@"chara3"] length] != 0) {
            request.value = [userDefaults dataForKey:@"chara3"];
        }else{
            request.value = [@"なし,なし,入力なし,0,0,0" dataUsingEncoding:NSUTF8StringEncoding];
        }
        [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
}

//書き込み要求が来た場合
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    
    for (CBATTRequest *request in requests) {
        
        NSString *res = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
        
        //受け取ったデータを項目ごとに分けてArrayに保存
        NSArray *unionArray = [res componentsSeparatedByString:@","];
        
        //データを投げる
        [self ReceiveProfile:unionArray];
        
    }
}

//受け取ったデータを通知したり保存したりViewCon呼び出したり
- (void)ReceiveProfile:(NSArray*)profileArray{
    
    if ([[profileArray objectAtIndex:0] isEqualToString:@"入力なし"] || [[profileArray objectAtIndex:1] isEqualToString:@"入力なし"]) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *myNameAndGreetingArray = [[[NSString alloc]initWithData:[userDefaults dataForKey:@"chara1"] encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
    if ([[userDefaults dataForKey:@"chara1"] length] == 0) {
        return;
    }
    else if ([[myNameAndGreetingArray objectAtIndex:0] isEqualToString:@"入力なし"] || [[myNameAndGreetingArray objectAtIndex:1] isEqualToString:@"入力なし"]) {
        return;
    }
    
    //名前と挨拶だけ通知
    NSArray *nofityArray = [NSArray arrayWithObjects:[profileArray objectAtIndex:0],[profileArray objectAtIndex:1], nil];
    [self.delegate nofityMessage:nofityArray];
    
    //フィルター
    NSMutableArray *mProfileArray = [profileArray mutableCopy];//mutableCopyじゃないと落ちる(copyだと中身はArrayのままらしい)
    
    if ([[mProfileArray objectAtIndex:8] isEqualToString:@"0"]) {
        [mProfileArray replaceObjectAtIndex:5 withObject:@"なし"];
    }else if([[userDefaults dataForKey:@"twitterName"] length] == 0){
        [mProfileArray replaceObjectAtIndex:5 withObject:@"自身が未入力のため交換されません"];
    }
    if ([[mProfileArray objectAtIndex:9] isEqualToString:@"0"]) {
        [mProfileArray replaceObjectAtIndex:6 withObject:@"なし"];
    }else if([[userDefaults dataForKey:@"facebookName"] length] == 0){
        [mProfileArray replaceObjectAtIndex:5 withObject:@"自身が未入力のため交換されません"];
    }
    if ([[mProfileArray objectAtIndex:10] isEqualToString:@"0"]) {
        [mProfileArray replaceObjectAtIndex:7 withObject:@"なし"];
    }else if([[[NSString alloc]initWithData:[userDefaults dataForKey:@"mail"] encoding:NSUTF8StringEncoding] isEqualToString:@"入力なし"]){
        [mProfileArray replaceObjectAtIndex:5 withObject:@"自身が未入力のため交換されません"];
    }
    NSArray *newProfileArray = [mProfileArray copy];
    
    // plistを読み込む
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"profile.plist"];
    NSArray *root = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSMutableArray *mRootArray = [NSMutableArray array];
    if ([root count] == 0) {
        
        [mRootArray addObject:newProfileArray];
    }
    else{
        //ArrayをMutableArrayに
        mRootArray = [root mutableCopy];
        //MutableArrayに受け取ったデータを追加
        [mRootArray addObject:newProfileArray];
        //Arrayのデータが多過ぎたら先頭を消す
        if ([mRootArray count] > 10) {
            [mRootArray removeObjectAtIndex:0];
        }
    }
    //MutableArrayをArrayに
    NSArray *newArray = [mRootArray copy];
    
    //Arrayをplistに保存
    BOOL successful = [newArray writeToFile:filePath atomically:YES];
    
    if (successful) {
        NSLog(@"保存成功");
    }
    else if (!successful) {
        NSLog(@"保存失敗");
    }
    
    [self.delegate addProfile];
}


@end
