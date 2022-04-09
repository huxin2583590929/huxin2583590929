//
//  MYCollectionVIew.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/17.
//

#import "MYCollectionVIew.h"
#import <Masonry/Masonry.h>

@interface MYCollectionVIew ()

@property (nonatomic, strong) NSMutableDictionary *cellDic;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isBeganMove;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, copy) NSArray *labelNames;

@end

@implementation MYCollectionVIew

- (instancetype)init {
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"collectionview";
        self.isBeganMove = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.labels = [[NSMutableArray alloc] init];
    self.labelNames = [[NSArray alloc] initWithObjects:@"apple", @"banana", @"pear", @"strawberry", @"orange", @"draggonfruit", @"cherry", @"grape", @"watermelon", @"lemon", nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(110, 60);
    //行间距和列间距
    layout.minimumLineSpacing = 30;
    //layout.minimumInteritemSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    //layout.estimatedItemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter          withReuseIdentifier:@"footer"];
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self.collectionView];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    /*记录
    发现出现cell复用导致的内容叠加问题
    解决方法：
    1.给每个cell设置唯一标识，如下。    2.在每次重用cell之前remove所有subview。    3.使用自定义的collectionviewcell
    NSString *identifier = [self.cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
   if(identifier == nil){
         identifier = [NSString stringWithFormat:@"selectedBtn%@", [NSString stringWithFormat:@"%@", indexPath]];

         [self.cellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
         // 注册Cell（把对cell的注册写在此处）
         [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
     */
    //查找可复用的Cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *v in cell.subviews) {
        [v removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100,50)];
    label.text = self.labelNames[arc4random() % 10];
    [cell addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = UIColor.redColor;
    
    [self.labels addObject:label];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveCollectionViewCell:)];
       [cell addGestureRecognizer:longPress];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //处理数据（删除之前的位置数据，插入到新的位置）
    UILabel *selectedLabel = self.labels[sourceIndexPath.item];
    [self.labels removeObjectAtIndex:sourceIndexPath.item];
    [self.labels insertObject:selectedLabel atIndex:destinationIndexPath.item];
}

- (void)moveCollectionViewCell:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            if (!self.isBeganMove) {
                self.isBeganMove = YES;
                //获取点击的cell的indexPath
                NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
                
                //开始移动对应的cell
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
                
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            //移动cell
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            self.isBeganMove = false;
            //结束移动
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

//每个cell的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}

//选择某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
}

//Header和Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //同样会出现复用导致的内容叠加，解决方法同上方cell
    
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]) {
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
        for (UIView *v in view.subviews) {
            [v removeFromSuperview];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是footer%ld",indexPath.section];
        [view addSubview:label];
        return view;
    }
    else {
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
        for (UIView *v in view.subviews) {
            [v removeFromSuperview];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        //view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是header%ld",indexPath.section];
        [view addSubview:label];
        return view;
    }
}

//返回headerview的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {320,45};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {320,45};
    return size;
}

@end
