//
//  ViewController.swift
//  emailDemo
//
//  Created by 张亚峰 on 2018/8/29.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ZYFEmoticonManager.shared
       // print(manager.packages)
        //----测试表情图像-----
        print(manager.packages.last?.emoticons.first?.image)
        
        //----测试查找表情
        print(ZYFEmoticonManager.shared.findEmoticon(string: "[爱你]"))
        
        let lm = ZYFEmoticonManager.shared.findEmoticon(string: "[马上有对象]")
        
        demoLabel.attributedText = lm?.imageText(font: demoLabel.font)
        
    }

}

