//
//  TestViewController.m
//  ZJTest
//
//  Created by 庄记 on 2017/2/22.
//  Copyright © 2017年 庄记. All rights reserved.
//

#import "TestMyViewController.h"
#import "ContentViewController.h"

@interface TestMyViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, weak) UICollectionView *menuCollectionView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, strong) NSArray *pageViewArray;
@property (nonatomic, assign) NSInteger index;
@end

@implementation TestMyViewController

- (NSArray *)pageViewArray {
    if (!_pageViewArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            ContentViewController *initViewController = [[ContentViewController alloc] init];
            initViewController.content = [NSString stringWithFormat:@"This is %d",i];
            [array addObject:initViewController];
        }
        _pageViewArray = [[NSArray alloc] initWithArray:array];
    }
    return _pageViewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dict];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    ContentViewController *contentViewController = self.pageViewArray[0];
    NSArray *newArray = [NSArray arrayWithObjects:contentViewController, nil];
    [_pageViewController setViewControllers:newArray direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    CGRect rect = self.view.bounds;
    rect.origin.y = rect.origin.y + 40;
    _pageViewController.view.frame = rect;
    
    for (UIView *view in _pageViewController.view.subviews) {
        NSLog(@"%@",view);
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            scrollView.bounces = NO;
        };
    }
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.frame.size.width/4, 40);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentSize = CGSizeMake(self.view.frame.size.width*2.5, 40);
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pageId"];
    _menuCollectionView = collectionView;
    [self.view addSubview:_menuCollectionView];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, collectionView.frame.size.height - 3, self.view.frame.size.width/4, 3)];
    self.bottomView = bView;
    self.bottomView.backgroundColor = [UIColor redColor];
    [_menuCollectionView addSubview:self.bottomView];
}

#pragma mark PageViewController 代理方法
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.pageViewArray indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    NSLog(@"%ld",index);
    UIViewController *controller = self.pageViewArray[index];
    return controller;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.pageViewArray indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    NSLog(@"%ld",index);
    if (index == [self.pageViewArray count]) {
        return nil;
    }
    UIViewController *controller = self.pageViewArray[index];
    return controller;
}

// 滚动结束以后
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        [self.menuCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
// 将要滚动的时候
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *vc = [pendingViewControllers firstObject];
    NSInteger idnex = [self.pageViewArray indexOfObject:vc];
    self.index = idnex;
}
#pragma mark collection dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pageId" forIndexPath:indexPath];
    CGFloat r = arc4random()%255;
    CGFloat g = arc4random()%255;
    CGFloat b = arc4random()%255;
    cell.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pageViewArray.count;
}
#pragma mark collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了！！！");
    UIViewController *controller = [self.pageViewArray objectAtIndex:indexPath.row];
    [self.menuCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (indexPath.row > self.index) {
        [self.pageViewController setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        [self.pageViewController setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    self.index = indexPath.row;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
