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
        
        
        emoticonString(string: "我[爱你]000[马上对象]ssss")
    }
    
    /// 将给定的字符串转换成属性文本
    ///
    /// - Parameter string: 完整的字符串
    /// - Returns: 属性文本
    func emoticonString(string: String) -> NSAttributedString {
        let attrString = NSAttributedString(string: string)
        
        //1.建立正则表达式，过滤所有的表情文字
        // [] () 都是正则表达式的关键字，如果参与匹配需要转义
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        //2.匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        //3.遍历所有匹配结果
        for m in matches {
            let r = m.range(at: 0)
            let subStr = (attrString.string as NSString).substring(with: r)
            print(subStr)
        }
        return attrString
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func demo1()  {
        //测试单例
        let manager = ZYFEmoticonManager.shared
        // print(manager.packages)
        //----测试表情图像-----
        print(manager.packages.last?.emoticons.first?.image)
        
        //----测试查找表情
        print(ZYFEmoticonManager.shared.findEmoticon(string: "[爱你]"))
        //----测试直接生成表情属性文本
        let lm = ZYFEmoticonManager.shared.findEmoticon(string: "[马上有对象]")
        
        demoLabel.attributedText = lm?.imageText(font: demoLabel.font)
    }
}

