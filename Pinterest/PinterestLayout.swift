//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by neal on 2017/9/5.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    //1
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath  indexPath:IndexPath, withWidth:CGFloat) -> CGFloat
    
    //2
    func collectionView(_ collectionView:UICollectionView, heightForAnnotationAtIndexPath indexPath:IndexPath, withWidth width: CGFloat) -> CGFloat
}


class PinterestLayout: UICollectionViewLayout {

    //1
    var delegate: PinterestLayoutDelegate!
    
    //2
    var numberOfColums = 2
    var cellPadding: CGFloat = 6.0
    
    //3
    private var cache = [UICollectionViewLayoutAttributes]()
    
    //4
    private var contentHeight:CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    
    override func prepare() {
        // 1 没有缓存时计算
        if cache.isEmpty {
            //2 设置xoffset
            let columnWidth = contentWidth / CGFloat(numberOfColums)
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColums {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            // 设置yoffset
            var column = 0
            var yOffset = [CGFloat](repeating:0, count: numberOfColums)
            
            //3 设置每个item
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                //4
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
            
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                //5
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                //6
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColums - 1 ) ? 0: column + 1;
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
