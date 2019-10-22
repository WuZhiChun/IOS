//
//  FirstViewController.swift
//  swift0830
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    //遵循协议 UITableViewDelegate,UITableViewDataSource
    var tabView: UITableView?
    
    //重用标识
    let cellID:String = "cellID"
    
    var imageArr:[Any] = [
        
        UIImage.init(named:"s1")!,
    
        UIImage.init(named:"s2")!,
        
        UIImage.init(named:"s3")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.title = "首页"

        //初始化
        self.tabView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        
        //设置代理
        self.tabView?.delegate = self
        
        self.tabView?.dataSource = self
        
        self.view.addSubview(self.tabView!)
        
//        消除多余行的线
        self.tabView?.tableFooterView = UIView()
        
        self.tabView?.tableHeaderView = RollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 200), imgArr: imageArr)
    }

    //表头数量，模块数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tabView?.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        }
        
        cell?.imageView?.image = UIImage.init(named: "b_0")
        cell?.textLabel?.text = "你好呀"
        cell?.detailTextLabel?.text = "今天天气怎么样"
        
        //消除选中灰色
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        //配件
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdlyVC  = ThirdlyViewController()
        
        //跳转到下一个视图控制区
        //导航跳转视图，用push 回来用pop
        
        self.navigationController?.pushViewController(thirdlyVC, animated: true)
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
