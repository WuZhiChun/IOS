//
//  FJCollectionViewCell.swift
//  swift0830
//
//  Created by Mac on 2019/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FJCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    var shop:ShopModel?{
        
        didSet{
            
            if let shop = shop{
                
                self.imageView.image = shop.image
                
                self.titleLab.text = shop.price
                
                
            }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
