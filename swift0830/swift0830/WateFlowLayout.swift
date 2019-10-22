//
//  WateFlowLayout.swift
//  swift0830
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@objc protocol  wateFlowLayoutDelegate {
    
    //处理图片的宽高ååå
    func wateFlowLayout(wateFlowLayout: WateFlowLayout, heightForRowAt indexPath:Int,itemWidth: CGFloat) -> CGFloat
    //列的数量
    @objc optional func columCoutInWateFlowLayout(wateFlowLayout: WateFlowLayout) -> Int
    
    //列的间距
    @objc optional func collumnMarginInWateFlowLayout(wateFlowLayout: WateFlowLayout) -> CGFloat
    
    //行间距
    @objc optional func rowMargInWateFlowLayout(wateFlowLayout: WateFlowLayout) -> CGFloat
    
    //边缘距离
    @objc optional func edgeInstInWateFlowlayout(wateFlowLayout: WateFlowLayout) -> UIEdgeInsets

    
}



class WateFlowLayout: UICollectionViewLayout {
    
    //协议代理属性
    weak var delegate:wateFlowLayoutDelegate!
    
    //默认的列的数量
    let defaultColunmCoun:Int = 2
    
    //默认的列间距
    let defaultColunmMargin:CGFloat = 10
    
    //默认的行间距
    let defaultRouMargin:CGFloat = 10
    
    //默认的边缘距离
    let defaultEdgeInsert: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    
    //内容的高度
    var contentHeight: CGFloat = 0
    
    //列的数量
    var _columnCount:Int = 2
    
    var columnCount:Int?{
        
        set{
            _columnCount = newValue!
        }
        
        get{
            
            if self.responds(to: #selector(self.delegate.columCoutInWateFlowLayout(wateFlowLayout:))){
                
                return self.delegate.columCoutInWateFlowLayout!(wateFlowLayout: self)
            }else {
                
                return _columnCount
            }
        }
    }
  
    
    var _columnMargin:CGFloat = 10
    
    //列间距
    var columnMargin:CGFloat?{
        
        set{
            _columnMargin = newValue!
        }
        
        get{
            
            if self.responds(to: #selector(self.delegate.columCoutInWateFlowLayout(wateFlowLayout:))){
                
                return self.delegate.collumnMarginInWateFlowLayout!(wateFlowLayout: self)
            }else{
                return _columnMargin
            }
            
        }
    }
    
    
    //行间距
    var _rowMargin:CGFloat = 10
    var rowMargin:CGFloat?{
        
        set{
            
            _rowMargin = newValue!
        }
        
        get{
            
            if self.responds(to: #selector(self.delegate.rowMargInWateFlowLayout(wateFlowLayout:))){
                return self.delegate.rowMargInWateFlowLayout!(wateFlowLayout: self)
            }else{
                
                return _rowMargin
            }
        }
    
    }
    
    
    //边缘距离
    var _edgeInset:UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    
    var edgeInset:UIEdgeInsets{
        
        set{
            
            _edgeInset = newValue
        }
        
        get{
            
            if self.responds(to: #selector(self.delegate.edgeInstInWateFlowlayout(wateFlowLayout:))){
                
                return self.delegate.edgeInstInWateFlowlayout!(wateFlowLayout: self)
            }else{
                
                return _edgeInset
            }
            
        }
    }
    
    
    //数组。  装属性

    var _attrsArr:Array<UICollectionViewLayoutAttributes>?
    
    var attrsArr:Array<UICollectionViewLayoutAttributes>? {
        
        set{
            
            _attrsArr = newValue
        }
        
        get{
            
            if _attrsArr == nil{
                _attrsArr = []
            }
            
            return _attrsArr
        }
    }
    
    //数组。 列的高度
    var _columnHeights:Array<Any>?
    
    var columnHeight:Array<Any>{
        
        set{
            
            _columnHeights = newValue
        }
        
        get{
            
            if _columnHeights == nil{
                _columnHeights = []
            }
            
            return _columnHeights!
        }
        
    }
    
    //在这个方法中做些初始化的操作
    //这个方法一定要调用
    override func prepare() {
        
        super.prepare()
        //内容的高度，初始化为0
        self.contentHeight = 0
        
        //清除计算的所有高度,刷新的时候调用这个方法
        self._columnHeights?.removeAll()
        
        for _ in 0..<self.columnCount! {
            
            self.columnHeight.append(self.edgeInset.top)
            
        }
        
        //属性的数组也要清除
        self.attrsArr?.removeAll()
        
        //获取item数量
        let count = self.collectionView?.numberOfItems(inSection:0)
        
        for i in 0..<count! {
            
            //位置索引
            let indexPath:IndexPath = IndexPath(item: i,section: 0)
            //获取indexpath位置的布局属性
            let attrs:UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: indexPath)!
            
            //添加到属性数组中
            self.attrsArr?.append(attrs)
        }
    }
    
    //返回数组，数组装的是
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.attrsArr
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        
        //目标列，初始化为0
        var desColumn = 0
        
        var minColumnHeight: CGFloat = self.columnHeight[0] as! CGFloat
   
        //找到最短列
        for i in 0..<columnCount! {
            
            let columnHeight:CGFloat = self.columnHeight[i] as! CGFloat
            if minColumnHeight > columnHeight {
                
                minColumnHeight = columnHeight
                
                //记录最短的列的索引
                desColumn = i
            }
        }
        
        //获取collection宽度
        let collection_W:CGFloat = (self.collectionView?.bounds.size.width)!
        
        let w:CGFloat = (collection_W - self.edgeInset.left - self.edgeInset.right - self.columnMargin! * CGFloat(self.columnCount! - 1)) / CGFloat(columnCount!)
        
        let h:CGFloat = self.delegate.wateFlowLayout(wateFlowLayout: self, heightForRowAt: indexPath.item, itemWidth: w)
        
        let  x:CGFloat = self.edgeInset.left + (w + self.columnMargin!) * CGFloat(desColumn)
        
        var y:CGFloat = minColumnHeight
        if y != self.edgeInset.top {
            
            y += self.rowMargin!
        }
        
        attrs.frame = CGRect.init(x: x, y: y, width: w, height: h)
        //更新目标列的高度
        self.columnHeight[desColumn] = attrs.frame.maxY
        
        //目标列的高度
        let columnHeight:CGFloat = self.columnHeight[desColumn] as! CGFloat
        
        //设置内容的高度
        if self.contentHeight < columnHeight {
            
            self.contentHeight = columnHeight
        }
        
        return attrs
        
    }
    
    override var collectionViewContentSize: CGSize{
        
        return CGSize(width: 0, height: self.contentHeight + self.edgeInset.bottom)
        
    }
    
    
    
}







