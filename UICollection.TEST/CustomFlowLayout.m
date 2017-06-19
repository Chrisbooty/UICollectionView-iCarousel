//
//  CustomFlowLayout.m
//  UICollection.TEST
//
//  Created by Chris on 2017/5/20.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "CustomFlowLayout.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@implementation CustomFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *attrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:self.collectionView.bounds] copyItems:YES];
    CGFloat scale;
    CGFloat offset;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            offset = fabs(attr.center.x - self.collectionView.contentOffset.x - self.collectionView.bounds.size.width * 0.5);
            scale = 1 - offset / (self.collectionView.bounds.size.width * 0.5) * 0.25;
            attr.transform = CGAffineTransformMakeScale(scale, scale);
        } else {
            offset = fabs(attr.center.y - self.collectionView.contentOffset.y - self.collectionView.bounds.size.height * 0.5);
            scale = 1 - offset / (self.collectionView.bounds.size.height * 0.5) * 0.25;
            
        }
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat itemW = self.itemSize.width;
        CGFloat margin = self.collectionView.contentInset.left;
        CGFloat index = roundf((proposedContentOffset.x + margin) / itemW);
        proposedContentOffset.x = index * self.collectionView.bounds.size.width - (index + 1) * margin;
    } else {
        CGFloat itemH = self.itemSize.height;
        CGFloat margin = self.collectionView.contentInset.top;
        CGFloat index = roundf((proposedContentOffset.y + margin) / itemH);
        proposedContentOffset.y = index * self.collectionView.bounds.size.height - (index+1) * margin;
        NSLog(@"proposedContentOffset==%@",NSStringFromCGPoint(proposedContentOffset));
    }
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}



@end
