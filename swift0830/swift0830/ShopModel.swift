//
//  ShopModel.swift
//  swift0830
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ShopModel: NSObject {

    //关键字 class 类型方法
    
    class func getAllShops() -> [ShopModel] {
    
        
        //创建数组， 里面装的是ShopModel对象
        var shops = [ShopModel]()
        
        if let url = Bundle.main.url(forResource: "shops", withExtension: "plist"){

            if let shopsFromePlist = NSArray.init(contentsOf: url)
            {

                for dic in shopsFromePlist {
                    
                    let shop = ShopModel(dic:dic as! NSDictionary)
                    
                    shops.append(shop)
                }


            }
        }
        return shops
    }
    
    var image:UIImage?
    var price:String?
    
    
    //指定构造器
    init(image:UIImage,price:String){
        
        self.image = image
        
        self.price = price
        
        }
    
    //关键字 便利构造器
    convenience init(dic:NSDictionary){
        
        let imgStr = dic["img"] as? String
        
        let img = UIImage.init(named:imgStr!)
        
        let price = dic["price"] as? String
        
        self.init(image: img!, price:price!)
        
    }
    
    
}
