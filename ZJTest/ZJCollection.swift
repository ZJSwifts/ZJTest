//
//  ZJCollection.swift
//  ZJExtension
//
//  Created by apple1 on 2016/11/22.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation
import UIKit

struct ZJCollection {
    var totalWidth:CGFloat
    var gaps:CGSize
    var insets:UIEdgeInsets
    var widthHeightRate:CGFloat
    var itemsRows:Int
    
    static func setCollectionViewForItems(collectionView:UICollectionView , itemRows: Int , widthHeightRate:CGFloat , totalWidth: CGFloat) -> CGSize {
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let gaps = CGSize(width: layout.minimumInteritemSpacing + 0.2, height: layout.minimumLineSpacing + 0.2)
        let sizeCollection = ZJCollection(totalWidth:totalWidth , gaps:gaps , insets:layout.sectionInset , widthHeightRate:widthHeightRate, itemsRows:itemRows)
        layout.itemSize = sizeCollection.itemSize()
        return sizeCollection.itemSize()
    }
    
    func itemSize() -> CGSize {
        let contentWidth = totalWidth - insets.left - insets.right
        let itemWidth = (contentWidth - CGFloat(itemsRows - 1) * gaps.width) / CGFloat(itemsRows)
        let itemSize = CGSize(width: itemWidth, height: itemWidth * widthHeightRate)
        return itemSize
    }
}
