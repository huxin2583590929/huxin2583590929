//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by HuXin on 2021/7/13.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableDictionary *linesProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, weak) BNRLine *selectedLine;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.selectedLine = nil;
        self.linesProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        //双击手势
        UITapGestureRecognizer *doubleTaprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        
        doubleTaprecognizer.numberOfTapsRequired = 2;
        doubleTaprecognizer.delaysTouchesBegan = YES;
        
        //单机手势
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [tapRecognizer requireGestureRecognizerToFail:doubleTaprecognizer];
        tapRecognizer.delaysTouchesBegan = YES;

        
        //长按
        UILongPressGestureRecognizer *pressPecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        
        //拖动
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        
        [self addGestureRecognizer:doubleTaprecognizer];
        [self addGestureRecognizer:tapRecognizer];
        [self addGestureRecognizer:pressPecognizer];
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return  self;
}

//拖动手势
- (void)moveLine:(UIPanGestureRecognizer *)gr {
    //如果没有被选中的线条
    if (!self.selectedLine) {
        return;
    }
    
    // 如果菜单项可见，返回
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController.isMenuVisible ) {
        return;
    }
    NSLog(@"%ld",gr.state);
    
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
            
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
            
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        [self setNeedsDisplay];
            
        [gr setTranslation:CGPointZero inView:self];
    }
}

//长按手势
- (void)longPress:(UIGestureRecognizer *)gr {
    NSLog(@"longpress");
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesProgress removeAllObjects];
        }
    }
    else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

//双击手势
- (void)doubleTap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized Double Tap");
    
    [self.linesProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

//单击手势
- (void)tap:(UITapGestureRecognizer *)gr {
    NSLog(@"Recognizer me");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}


- (void)deleteLine:(id)sender {
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

//手指触碰屏幕记录degin和end
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.selectedLine = nil;
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
        
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesProgress[key] = line;
    }
    [self setNeedsDisplay];
}

//实时记录currentLine的end
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.selectedLine = nil;
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesProgress[key];
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

//触碰结束记录
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesProgress[key];
        
        [self.finishedLines addObject:line];
        
        [self.linesProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void)strokeLine:(BNRLine *)line {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesProgress) {
        [self strokeLine:self.linesProgress[key]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BNRLine *)lineAtPoint:(CGPoint)p {
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return  l;
            }
        }
    }
    return  nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

@end
