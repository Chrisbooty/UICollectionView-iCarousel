//
//  ViewController.m
//  UICollection.TEST
//
//  Created by Chris on 2017/5/20.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "ViewController.h"
#import "CustomFlowLayout.h"
#import "CollectionViewCell.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString * const cellId = @"CollectionViewCell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

/** collection */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupCollection];
    
}

- (void)setupCollection
{
    CGFloat collectionH = 200;
    CGFloat margin = 20;
    CGFloat itemH = (collectionH - margin * 2);
    CGFloat itemW = (KWidth - margin * 2);
    
    
    CustomFlowLayout *layout = ({
        CustomFlowLayout *layout = [CustomFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = margin;
        layout;
    });
    
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, KWidth, collectionH) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
        collectionView;
    });
    
    _collectionView = collectionView;
    
    [self.view addSubview:collectionView];
}

#pragma mark -collection代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.imgV.image = [UIImage imageNamed:@"temp"];
    
    return cell;
}

@end
