//
//  FjButton.swift
//  swift0830
//
//  Created by Mac on 2019/10/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FjButton: UIButton {

    //按钮是否上去了
    var isUP:Bool = false
    
    //按钮的数字
    var num:Int?
    
    var orginalCenter:CGPoint = CGPoint(x: 0, y: 0)
    
    //imv设置FJButton 的属性，应该他们会绑定子啊一起
    var imv:FJImageView?

}
