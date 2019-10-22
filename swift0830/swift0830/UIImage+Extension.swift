
//
//  UIImage+Extension.swift
//  swift0830
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

import  UIKit

//关键字扩展
extension UIImage {
    
   class func rendModel(name: String) -> UIImage {
        
    let img:UIImage = UIImage.init(named: name)!
        
        return img.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}
