//
//  JAWaterFallLayout.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/12.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

@objc protocol JAWaterFallLayoutDelegate {
    //waterFall的列数
    func columOfWaterFall(_ collectionView: UICollectionView) -> Int
    //每个item的高度
    func waterFall(_ collectionView: UICollectionView , layout waterFallLayout: JAWaterFallLayout , heightForItemAt indexPath: IndexPath) -> CGFloat
}

class JAWaterFallLayout: UICollectionViewLayout {
    
    weak var delegate: JAWaterFallLayoutDelegate?
    
    @IBInspectable var lineSpacing: CGFloat = 0
    
    @IBInspectable var columnSpacing: CGFloat = 0
    
    @IBInspectable var sectionTop: CGFloat = 0 {
        willSet {
            sectionInsets.top = newValue
        }
    }
    
    @IBInspectable var sectionLeft: CGFloat = 0 {
        willSet {
            sectionInsets.left = newValue
        }
    }
    
    
    @IBInspectable var sectionRight: CGFloat = 0 {
        willSet {
            sectionInsets.right = newValue
        }
    }
    
    @IBInspectable var sectionBottom: CGFloat = 0 {
        willSet {
            sectionInsets.bottom = newValue
        }
    }
    
    @IBInspectable var sectionInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    private var columnHeight: [Int:CGFloat] = [Int : CGFloat]()
    private var attributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    init(lineSpacing: CGFloat , columnSpacing: CGFloat , sectionInsets: UIEdgeInsets) {
        super.init()
        self.lineSpacing = lineSpacing
        self.columnSpacing = columnSpacing
        self.sectionInsets = sectionInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var collectionViewContentSize: CGSize {
        var maxHeight: CGFloat = 0
        for height in columnHeight.values {
            if height > maxHeight {
                maxHeight = height
            }
        }
        return CGSize.init(width: collectionView?.frame.width ?? 0, height: maxHeight + sectionInsets.bottom)
    }
    
    override func prepare() {
        super.prepare()
        guard collectionView != nil else { return }
        if let columnCount = delegate?.columOfWaterFall(collectionView!) {
            for i in 0..<columnCount {
                columnHeight[i] = sectionInsets.top
            }
        }
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        attributes.removeAll()
        for i in 0..<itemCount {
            if let att = layoutAttributesForItem(at: IndexPath.init(row: i, section: 0)) {
                attributes.append(att)
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let collectionView = collectionView {
            let att  = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            let width = collectionView.frame.width
            if let columnCount = delegate?.columOfWaterFall(collectionView) {
                guard columnCount > 0 else { return nil}
                let totalWidth = width - sectionInsets.left - sectionInsets.right - (CGFloat(columnCount) - 1) * columnSpacing
                let itemWidth = totalWidth / CGFloat(columnCount)
                let itemHeight = delegate?.waterFall(collectionView, layout: self, heightForItemAt: indexPath)
                var minIndex = 0
                for column in columnHeight {
                    if column.value < columnHeight[minIndex] ?? 0 {
                        minIndex = column.key
                    }
                }
                let itemX = sectionInsets.left + (columnSpacing + itemWidth) * CGFloat(minIndex)
                let itemY = (columnHeight[minIndex] ?? 0) + lineSpacing
                att.frame = CGRect.init(x: itemX, y: itemY, width: itemWidth, height: itemHeight!)
                columnHeight[minIndex] = att.frame.maxY
            }
            return att
        }
        return nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}
