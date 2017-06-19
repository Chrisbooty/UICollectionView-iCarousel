# UICollectionView-iCarousel
* 用UICollectionView卡片展示视图iCarousel

继承UICollectionViewFlowLayout, 并重写以下方法, 达到始终有cell停在collectionView中间
```
// 修改cell滑动时大小
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *attrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:self.collectionView.bounds] copyItems:YES];
    CGFloat scale;
    CGFloat offset;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 设置collection在滑动时, cell的大小
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

// 返回collection滑动手指松开后, collection最终的contentOffset
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        // cell 宽度
        CGFloat itemW = self.itemSize.width;
        // cell边框距离(未设置collection的contentInset, 默认为0)
        CGFloat margin = self.collectionView.contentInset.left;
        // collection在手指松开后,collection滑动到停止时, collectioncontentOffset
        CGFloat index = roundf((proposedContentOffset.x + margin) / itemW);
        // 修改collection最终的contentOffset, 使collection滑动到cell中间
        proposedContentOffset.x = index * self.collectionView.bounds.size.width - (index + 1) * margin;
    } else {
        CGFloat itemH = self.itemSize.height;
        CGFloat margin = self.collectionView.contentInset.top;
        CGFloat index = roundf((proposedContentOffset.y + margin) / itemH);
        proposedContentOffset.y = index * self.collectionView.bounds.size.height - (index+1) * margin;
    }
    return proposedContentOffset;
}
```
