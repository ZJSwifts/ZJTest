//
//  JACollection.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/19.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation
import UIKit

struct JACollection {
    var insets:UIEdgeInsets
    var gaps:CGSize
    var itemsInRow:Int
    var number:Int
    var totalWidth:CGFloat
    var heightWidthRate:CGFloat
    
    static func setCellSizeForCollection(_ collection:UICollectionView , itemRow:Int , heightWidthRate:CGFloat , totalWidth: CGFloat) -> CGSize {
        let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        let gaps = CGSize(width: (layout?.minimumInteritemSpacing)! + 0.2 , height: (layout?.minimumLineSpacing)! + 0.2)
        let sizeCollection = JACollection(insets: (layout?.sectionInset)!, gaps: gaps, itemsInRow: itemRow, number: 100, totalWidth: totalWidth, heightWidthRate: heightWidthRate)
        layout?.itemSize = sizeCollection.itemSize()
        return sizeCollection.itemSize()
    }
    
    func itemSize() -> CGSize {
        let contentWidth =  totalWidth - insets.left - insets.right
        let width = (contentWidth - CGFloat(itemsInRow - 1) * gaps.width)/CGFloat(itemsInRow)
        let height = width*heightWidthRate
        return CGSize(width: width, height: height)
    }
    
    func totalHeight() -> CGFloat {
        let lastRow = (number - 1) / itemsInRow
        let nSize = itemSize()
        return insets.top + insets.bottom + CGFloat(lastRow)*nSize.height
    }
    
    
}

extension UICollectionViewFlowLayout {
    func fixSlit(rect: inout CGRect , colCount:CGFloat , space:CGFloat = 0) -> CGFloat {
        let totalSpace = (colCount - 1) * space
        let itemWidth = (rect.width - totalSpace) / colCount
        var realItemWidth = floor(itemWidth) + 0.5
        if realItemWidth < itemWidth {
            realItemWidth += 0.5
        }
        let realWidth = colCount * realItemWidth + totalSpace
        let pointX = (realWidth - rect.width) / 2
        rect.origin.x = -pointX
        rect.size.width = realWidth
        return (rect.width - totalSpace) / colCount
    }
    
    func fixSlit1(rect: inout CGRect , colCount:CGFloat , space:CGFloat) -> CGFloat {
        let totalSpace = (colCount - 1) * space
        let itemWidth = (rect.width - totalSpace) / colCount
        var realItemWidth = floor(itemWidth) + 0.5
        if realItemWidth < itemWidth {
            realItemWidth += 0.5
        }
        let realWidth = colCount * realItemWidth + totalSpace
        let pointX = (realWidth - rect.width) / 2
        rect.origin.x = -pointX
        rect.size.width = realWidth
        return (rect.width - totalSpace) / colCount
    }
}
