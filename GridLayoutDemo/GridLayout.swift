//
//  GridLayout.swift
//  GridLayoutDemo
//
//  Created by Robert Ryan on 8/6/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewLayout {

    var itemSpacing: CGFloat = 5
    var rowSpacing: CGFloat = 5
    var insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    private var itemSize: CGSize!
    private var rowsPerPage: Int!
    private var columnsPerPage: Int!
    private let maxColumnsPerPage = 5
    private let maxRowsPerPage = 5
    private var pages: Int = 0
    
    override func prepare() {
        super.prepare()
        
        let count = collectionView!.numberOfItems(inSection: 0)
        if count == 0 { return }
        
        columnsPerPage = min(maxColumnsPerPage, Int(ceil(sqrt(Double(count)))))
        let rows = Int(ceil(Double(count) / Double(columnsPerPage)))
        pages = Int(ceil(Double(rows) / Double(maxRowsPerPage)))
        rowsPerPage = min(rows, maxRowsPerPage)
        
        let width = (collectionView!.bounds.width - (itemSpacing * CGFloat(columnsPerPage - 1)) - insets.left - insets.right) / CGFloat(columnsPerPage)
        let height = (collectionView!.bounds.height - (rowSpacing * CGFloat(rowsPerPage - 1)) - insets.top - insets.bottom) / CGFloat(rowsPerPage)
        itemSize = CGSize(width: width, height: height)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width * CGFloat(pages),
                      height: collectionView!.bounds.height)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attributes.center = centerForItem(at: indexPath)
        attributes.size = itemSize
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (0 ..< collectionView!.numberOfItems(inSection: 0))
            .map { IndexPath(item: $0, section: 0) }
            .filter { rect.intersects(rectForItem(at: $0)) }
            .flatMap { layoutAttributesForItem(at: $0) }
    }
    
    private func centerForItem(at indexPath: IndexPath) -> CGPoint {
        
        let rect = rectForItem(at: indexPath)
        
        return CGPoint(x: rect.midX, y: rect.midY)
    }
    
    private func rectForItem(at indexPath: IndexPath) -> CGRect {
        let page = indexPath.item / (maxRowsPerPage * maxColumnsPerPage)
        let itemOnPage = indexPath.item % (maxRowsPerPage * maxColumnsPerPage)
        let row = itemOnPage / columnsPerPage
        let col = itemOnPage - row * columnsPerPage
        let point = CGPoint(x: CGFloat(col) * (itemSize.width + itemSpacing) + CGFloat(page) * collectionView!.bounds.width + insets.left,
                            y: CGFloat(row) * (itemSize.height + rowSpacing) + insets.top)
        return CGRect(origin: point, size: itemSize)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
