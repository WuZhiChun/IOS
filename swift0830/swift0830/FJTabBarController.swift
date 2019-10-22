//
//  FJTabBarController.swift
//  swift0830
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addAllChildViewController()
        
    }

    // 给分栏控制器中添加子视图控制器
    func addAllChildViewController() {

        let firstVC = FirstViewController()

        self.addOneChildViewContriller(vc: firstVC, title: "首页", img: UIImage.rendModel(name: "night_tabbar_jcon_bar_importanNews_highlight"), selectedImg: UIImage.rendModel(name: "night_tabbar_jcon_bar_importanNews_normal"))



        let secondVC = SecondViewController()

        self.addOneChildViewContriller(vc: secondVC, title: "图片", img: UIImage.rendModel(name: "night_tabbar_jcon_bar_highlight"), selectedImg: UIImage.rendModel(name: "night_tabbar_jcon_bar_normal"))

    }

    //封装的添加子视图控制器
    func addOneChildViewContriller(vc: UIViewController, title: String, img:UIImage, selectedImg:UIImage) {
        let nav = FJNavigationController.init(rootViewController:vc)

        nav.tabBarItem.title = title

        nav.tabBarItem.image = img

        nav.tabBarItem.selectedImage = selectedImg

        self.addChildViewController(nav)


    }

    //加载视图
    override func loadView() {
        super.loadView()

        // 获取项目中的UITabBarItem
//        let	 item = UITabBarItem.appearance()

//        选中
//        创建一个key值为string类型，value值的Any型字典
//        var attrSel = [String : Any]()
//
//        attrSel[NSFontAttributeName] = UIFont.systemFont(ofSize: 14)
//
//        attrSel[NSForegroundColorAttributeName] = UIColor.red
//
//
//        item.setTitleTextAttributes(attrSel, for: UIControlState.selected)
//
//        //正常
//
//        var attrNOr = [String : Any]()
//        attrNOr[NSFontAttributeName] = UIFont.systemFont(ofSIze:14)
//
//        item.setTitleTextAttributes(attrNOr, for: UIControlState.normal)

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()


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

