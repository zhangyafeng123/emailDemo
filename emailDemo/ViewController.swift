//
//  ViewController.swift
//  emailDemo
//
//  Created by 张亚峰 on 2018/8/29.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ZYFEmoticonManager.shared
       // print(manager.packages)
        print(manager.packages.last?.emoticons.first?.image)
    }

}

