//
//  SecondViewController.swift
//  swift0830
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,wateFlowLayoutDelegate{

    var shopArr = ShopModel.getAllShops()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.title = "图片"
        
        let layout = WateFlowLayout.init()
        
        layout.delegate = self
        
        //创建UICollectionView对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        //设置代理
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //注册xib
        collectionView.register(UINib.init(nibName: "FJCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColletionCellID")
        
        
        //添加到self.view上去
        self.view.addSubview(collectionView)
    }

    

   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return self.shopArr.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColletionCellID", for: indexPath) as? FJCollectionViewCell
        
        cell?.shop = shopArr[indexPath.item]
        
        return cell!
    }
    
    
    //协议方法计算出（item）图片的实际高度
    func wateFlowLayout(wateFlowLayout: WateFlowLayout, heightForRowAt indexPath: Int, itemWidth: CGFloat) -> CGFloat {
        
        
        let shop:ShopModel = self.shopArr[indexPath]
        
        return CGFloat(itemWidth * (shop.image?.size.height)! / (shop.image?.size.width)!)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
