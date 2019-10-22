//
//  FJNaviewController.swift
//  swift0830
//
//  Created by Mac on 2019/10/18.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    //重写父类的pushViewController方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            
            //创建UIButton初始化
            let btn:UIButton = UIButton(type:UIButtonType.custom)
            
            //设置图片
            btn.setImage(UIImage.init(named: "back"), for: UIControlState.normal)
            
            //适配尺寸
            btn.sizeToFit()
            //添加点击事件
            btn.addTarget(self, action: #selector(back), for: UIControlEvents.touchUpInside)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
            //隐藏底部的bar
            viewController.hidesBottomBarWhenPushed = true
            
    }
        //真正的push
        super.pushViewController((viewController), animated: true)
}
    
    @objc func back() {
        
        self.popViewController(animated: true)
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
