//
//  QCRound.m
//  Hyatt
//
//  Created by QC.L on 15/5/25.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import "QCRound.h"

#import "QCRoundCell.h"


#define kCollectionView @"reuse"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define kWidth [UIScreen mainScreen].bounds.size.width

#define kCollectionSection 100

@interface QCRound () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) void (^ configureCell)(QCRoundCell *cell, id model);
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;
@end


@implementation QCRound

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowlayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        self.flowlayout.minimumInteritemSpacing = 0;
        self.flowlayout.minimumLineSpacing = 0;
        self.flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:self.flowlayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[QCRoundCell class] forCellWithReuseIdentifier:kCollectionView];

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, 30)];
        self.pageControl.center = CGPointMake(frame.size.width / 2, frame.size.height - 20);
        [self addSubview:self.pageControl];
        
        [self addTimer];

        
    }
    return self;
}

- (void)changeFrame:(CGRect)frame
{
    self.flowlayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    self.collectionView.frame = frame;
    self.pageControl.center = CGPointMake(frame.size.width / 2, frame.size.height - 20);
//    self.collectionView.scrollEnabled = NO;
//    [self removeTimer];
//    [self.collectionView reloadData];
}

- (void)configureCellBlock:(void (^)(QCRoundCell *cell, id model))configureCell
{
    self.configureCell = configureCell;
    [self.collectionView reloadData];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.imageArr[(NSUInteger)indexPath.row];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QCRoundCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCollectionView forIndexPath:indexPath];
    id model = [self itemAtIndexPath:indexPath];
    if (self.configureCell) {
        self.configureCell(cell, model);
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count;
}

- (void)setImageArr:(NSMutableArray *)imageArr
{
    _imageArr = imageArr;
    self.pageControl.numberOfPages = _imageArr.count;
    
    

    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kCollectionSection / 2] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (void)addTimer
{
    [self.timer invalidate];
    self.timer = nil;
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(scrollNext) userInfo:nil repeats:YES];
    // NSRunLoop持有NSTimer, 保证安全
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}


- (void)removeTimer
{
    // 将NSTimer释放(release操作)
    [self.timer invalidate];
    // 置空
    self.timer = nil;
}

- (NSIndexPath *)returnIndexPath
{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    currentIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row inSection:kCollectionSection / 2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPath;
}

- (void)scrollNext
{
    NSIndexPath *indexPath = [self returnIndexPath];
    NSInteger item = indexPath.row + 1;
    NSInteger section = indexPath.section;
    if (item == _imageArr.count) {
        item = 0;
        section++;
    }
    self.pageControl.currentPage = item;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:item inSection:section];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.collectionView) {
        [self addTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        
        NSInteger page = (NSInteger)(scrollView.contentOffset.x / (kWidth - 20)) % self.imageArr.count;
        self.pageControl.currentPage = page;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kCollectionSection;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickedIndexPath:)]) {
        [self.delegate clickedIndexPath:indexPath];
    }
}

@end
