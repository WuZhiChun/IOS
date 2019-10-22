//
//  RollView.swift
//  swift0830
//
//  Created by Mac on 2019/10/18.
//  Copyright © 2019 Mac. All rights reserved.
//
//轮播图
import UIKit

//遵循协议
class RollView: UIView,UIScrollViewDelegate {

   //轮播视图
    var scrollView:UIScrollView?
    
    //图片数组
    var imgArr:[Any]?
    
    //定时器
    var timer:Timer?
    
    var time:TimeInterval = 1
    
    //小圆点
    var pagController:UIPageControl?
    
    //convenience 关键字
    convenience init (frame:CGRect,imgArr:[Any]) {
        
        //调用指定构造器
        self.init(frame:frame)
        
        self.imgArr = imgArr
        
        self.initUI()
        
        self.initTime()

    }
    
    
    func initUI() {
        
        //创建滚动视图对象并初始化
        self.scrollView = UIScrollView.init(frame: self.bounds)
        
        //是否分页
        self.scrollView?.isPagingEnabled = true
        
        //不展示滚动条
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.showsVerticalScrollIndicator = false
        
        self.scrollView?.contentSize = CGSize(width: self.bounds.width * CGFloat((self.imgArr?.count)!), height: 0)
        
//        设置代理
        self.scrollView?.delegate = self
        
        //添加到RollView 视图上去
        self.addSubview(self.scrollView!)
        
        //创建UIpageControl  的对象并初始化，小圆点
        self.pagController = UIPageControl(frame:CGRect.init(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30))
        //设置小圆点的数量
        self.pagController?.numberOfPages = (self.imgArr?.count)!
        
        //当前页数
        self.pagController?.currentPage = 0
        
        //小圆点的颜色
        self.pagController?.pageIndicatorTintColor = UIColor.green
        
        //当前页数小圆点的颜色
        self.pagController?.currentPageIndicatorTintColor = UIColor.red
        
        //将pagcontroller 添加到底部视图上去
        self.addSubview(self.pagController!)
        
        let scroll_W = self.bounds.size.width
        
        let scroll_H = self.bounds.size.height
        
        //创建图片
        for i in 0..<self.imgArr!.count {
            
            //创建UIImageView并初始化
            let imgView = UIImageView(frame: CGRect.init(x: CGFloat(i) * scroll_W, y: 0, width: scroll_W, height: scroll_H))
            //添加图片
            imgView.image = self.imgArr?[i] as? UIImage
            
            self.scrollView?.addSubview(imgView)
        }
        
        
        
        
    }
    
    func initTime() {
        
        //当只有一张图片的时候不需要开启定时器
        if (self.imgArr?.count)! <= 1 {
            return
        }
        
        //如果定时器已开启，关掉
        if timer != nil {
            
            timer?.invalidate()
        }
        
        //创建定时器
        timer = Timer.scheduledTimer(timeInterval: self.time, target: self, selector: #selector(timeRun), userInfo: nil, repeats: true)
        
        //添加到RunLoop中
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    
}

    //每隔一秒运行这个方法一次。定时器
    @objc func timeRun() {
        let nextPage:Int = (self.pagController?.currentPage)! + 1
        
        let i: CGFloat = CGFloat(nextPage % (self.imgArr?.count)!)
        
        self.scrollView?.setContentOffset(CGPoint.init(x: (self.scrollView?.bounds.size.width)! * i, y: 0), animated: true)
}

    //滚动视图结束滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pagController?.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pagController?.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
    
    
    //定时器的移除
    deinit {
        
        if timer != nil {
            
            timer?.invalidate()
        }
    }
    
    //解决定时器被引用无法释放的问题
    override func willMove(toSuperview newSuperview: UIView?) {
        
        if newSuperview == nil && timer != nil {
            
            timer?.invalidate()
            
            timer = nil
            
        }
        
    }
    
    
}





