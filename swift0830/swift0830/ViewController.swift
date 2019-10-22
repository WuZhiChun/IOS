//
//  ViewController.swift
//  swift0830
//
//  Created by Mac on 2019/10/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //正确的数量
    var rightCount:Int = 0
    
    //装FjImage的数组
    var imgArr:Array<FJImageView> = []
    
    //装FjButton的数组
    var btnArr:Array<FjButton> = []

    //0...8数组
    var numArr:Array<Int> = [1,2,3,4,5,6,7,8]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatPassworlds()
        
        self.creatButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imgAnimation()
        self.btnAnimation()
    }

//    MARK: - 创建4个密码图片
    
    func creatPassworlds()  {
        
        //上面的图片宽度
        let imgHW = 70
        
        //列数
        let columnCount = 4
        
        //间隙
        let margin = (Int (SCREEN_W) - imgHW * columnCount) / (columnCount + 1)
        for i in 0...3 {
            
            //防止数字重复
            let index:Int = Int(arc4random() %
                uint(self.numArr.count))
            
            
            let img_num = self.numArr[index]
            
            
            self.numArr.remove(at: index)
            //产生 控件宽➕间隙，需要乘以倍数
            let num_x = i % columnCount
            //产生 控件➕间隙，需要乘以倍数
            let num_y = i / columnCount
            
            let x:CGFloat = CGFloat(margin + (imgHW + margin) * num_x)
            
            let y:CGFloat = CGFloat(58 + margin + (imgHW + margin) * num_y)
            
            //创建FJImgageVIew 对象并初始化
            let imgView = FJImageView();
            
            imgView.frame = CGRect(x: x, y: y, width:CGFloat(imgHW), height:CGFloat(imgHW))
            
            //添加到数据库
            self.imgArr.append(imgView)
            
            //添加图片
            imgView.image = UIImage.init(named	: "b_\(img_num)")
            
            imgView.num = img_num
            
            
            imgView.alpha = 0
            //添加到视图
            self.view.addSubview(imgView)
            
            }
        
        
    }
    
    //上面 4张图片的动画
    func imgAnimation() {
        
        for i in 0..<self.imgArr.count {
            
            let imgView = self.imgArr[i]
            
            UIView.animate(withDuration: 0.5, delay: Double(i) * 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                imgView.alpha = 1
            }, completion: nil)
        }
        
    }
    
    
    //下面9按钮的动画
    func btnAnimation() {
        
        for i in 0..<self.btnArr.count {
            let btn = self.btnArr[i]
            
            UIView.animate(withDuration: 0.5, delay: Double(i) * 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                btn.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
    }
    
    //MARK: - 创建9个数字按钮
    
    func creatButton(){
        
        let btnHW = 50
        
        let columnCount:Int = 3
        
        let margin:Int = (Int(SCREEN_W) - columnCount * btnHW) / (columnCount + 1)
        
        for i in 0...8 {
            let btn_num:Int = i
            
            let num_x = i % columnCount
            
            let num_y = i / columnCount
            
            let x:CGFloat = CGFloat(margin + (btnHW + margin) * num_x)
            
            let y:CGFloat = CGFloat(300 + (btnHW + margin) * num_y)
        
            let btn:FjButton = FjButton(type: UIButtonType.custom)
            
            btn.frame = CGRect(x: x, y: y, width: CGFloat(btnHW), height: CGFloat(btnHW))
            
            btn.setImage(UIImage.init(named: "s_\(btn_num)"), for: UIControlState.normal)
            
            btn.num = btn_num
            
            self.btnArr.append(btn)

            //将按钮的中心点点，赋值给存储属性orginalCenter
            btn.orginalCenter = btn.center
            
            
            //形变位移到屏幕的下方
            btn.transform = CGAffineTransform.init(translationX: 0, y: SCREEN_H)
            
            btn.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchUpInside)
            
            
            self.view.addSubview(btn)
        }
        
    }
    
    //点击按钮触发
    @objc func buttonClick(btn:FjButton) {
    
        if btn.isUP == false {
            
            for i in 0..<self.imgArr.count {
                let imgView = self.imgArr[i]
                
                if imgView.isCover == false {
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                            btn.center = imgView.center
                    }, completion: nil)
                    
                    
                    
                    btn.center = imgView.center
                    
                    btn.isUP = true
                    
                    imgView.isCover = true
                    
                    btn.imv = imgView
                    
                    if btn.num == imgView.num {
                        self.rightCount += 1
                        print("多一个页面")
                    
                        if self.rightCount == 4 {
                            print("跳转到下一个页面")
                            
                            // 创建分栏控制器对象
                            let tabBarCtr = FJTabBarController()
                            
                            // UIApplication.shared.keyWindow 获取主window
                            
                            UIApplication.shared.keyWindow?.rootViewController = tabBarCtr
                            
                            UIView.transition(with:UIApplication.shared.keyWindow!,duration: 1, options: UIViewAnimationOptions.transitionCurlUp, animations:nil, completion: nil)
                            
                        }
                    }
                    
                    break
                    
                }
                
                
            }
            
        } else{
            //动画回到原位置
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                btn.center = btn.orginalCenter
            }, completion: nil)
 
            if btn.imv?.num == btn.num {
                self.rightCount -=  1
                
                print("少一个数字")
            }
            
            
            btn.isUP = false
            btn.imv?.isCover = false
            btn.imv = nil
            
           
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }


}

