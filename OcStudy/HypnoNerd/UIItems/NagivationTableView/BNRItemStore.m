//
//  BNRItemStore.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/9.
//

#import "BNRItemStore.h"
#import "BNRTtem.h"
#import "AppDelegate.h"
#import "BNRImageStore.h"


@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

 + (instancetype)sharedStore {
     
    static BNRItemStore *sharedStore = nil;
    
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRTtemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
       // _privateItems = [[NSMutableArray alloc] init];
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (BNRTtem *)createItem {
    
    BNRTtem *item = [BNRTtem randomItem];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    item.valueInDollars = (int)[defaults integerForKey:BNRNextItemValuePrefsKey];
//    item.itemName = [defaults objectForKey:BNRNextItemNamePrefsKey];
//
//    NSLog(@"defaults = %@", [defaults dictionaryRepresentation]);
    
    [self.privateItems addObject:item];
    
     return item;
}

- (void)removeItem:(BNRTtem *)item {
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromInndex ToIndex:(NSUInteger)toIndex {
    
    if (fromInndex == toIndex) {
        return;
    }
    
    BNRTtem *item = self.privateItems[fromInndex];
    
    [self.privateItems removeObjectAtIndex:fromInndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
    
    
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
