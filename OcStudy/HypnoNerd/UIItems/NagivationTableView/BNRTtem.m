//
//  BNRTtem.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/8.
//

#import "BNRTtem.h"

@implementation BNRTtem



+ (instancetype)randomItem {
    
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    BNRTtem *newItem = [[self alloc] initWithItemName:randomName
                                       valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.itemName forKey:@"itemName"];
    [coder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [coder encodeObject:self.itemKey forKey:@"itemKey"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _itemName = [coder decodeObjectForKey:@"itemName"];
        _serialNumber = [coder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [coder decodeObjectForKey:@"dateCreated"];
        _valueInDollars = [coder decodeIntForKey:@"valueInDollars"];
        _itemKey = [coder decodeObjectForKey:@"itemKey"];
    }
    return self;
}



- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
   
    self = [super init];
    
    if (self) {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
        self.itemImage = [[UIImageView alloc] init];
        
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        self.itemKey = key;
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}


- (NSString *)description {
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d,recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    return descriptionString;
}
- (void)dealloc {
    NSLog(@"Destoryed: %@",self);
}

@end
