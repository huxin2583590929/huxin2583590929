//
//  _ZXYBHandWritingBoardManager.h
//  BJLiveCore
//
//  Created by xijia dai on 2021/5/27.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface _ZXYBHandWritingBoardManager : NSObject

@property (nonatomic, readonly) NSArray<CBPeripheral *> *availableCBDevices;
@property (nonatomic, readonly) CBPeripheral *handWritingBoard;
@property (nonatomic, readonly) BOOL handWritingBoardConnected;
@property (nonatomic, readonly) BOOL findSameDevice;
@property (nonatomic, readonly) BOOL connectedDeviceSleep;

@property (nonatomic, copy) void (^connectFailedCallback)(CBPeripheral *handWritingBoard);
@property (nonatomic, copy) void (^pointDidMoveCallback)(CGPoint point, CGFloat pressure, CGSize showSize, UIGestureRecognizerState state);
@property (nonatomic, copy) void (^writingBoardCommandCallback)(NSInteger commandKey);

- (void)scanBluetoothDevice;
- (void)stopScan;
- (void)connect:(CBPeripheral *)device;
- (void)disconnect;

// 蓝牙是否可用
- (BOOL)isValiableBluetooth;

@end

NS_ASSUME_NONNULL_END
