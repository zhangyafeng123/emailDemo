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
        
        //倒序遍历，否则前面的长度会失效
        //demoLabel.attributedText = emoticonString(string: "我[爱你]啊[笑哈哈]!")
        demoLabel.attributedText = ZYFEmoticonManager.shared.emoticonString(string: "我[爱你]啊[笑哈哈]!", font: demoLabel.font)
    }
    
    /// 将给定的字符串转换成属性文本
    /// 关键点要按照匹配的结果倒叙替换属性文本
    /// - Parameter string: 完整的字符串
    /// - Returns: 属性文本
    func emoticonString(string: String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: string)
        
        //1.建立正则表达式，过滤所有的表情文字
        // [] () 都是正则表达式的关键字，如果参与匹配需要转义
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrString
        }
        //2.匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        //3.遍历所有匹配结果
        for m in matches.reversed() {
            let r = m.range(at: 0)
            let subStr = (attrString.string as NSString).substring(with: r)
            // 1> 使用 subStr 查找对应的表情符号
            if let em = ZYFEmoticonManager.shared.findEmoticon(string: subStr) {
                //2> 使用表情符号中的属性文本，替换原有的属性文本的内容
                attrString.replaceCharacters(in: r, with: em.imageText(font: demoLabel.font))
            }
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

