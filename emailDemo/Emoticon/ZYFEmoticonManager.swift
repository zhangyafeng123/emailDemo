//
//  ZYFEmoticonManager.swift
//  emailDemo
//
//  Created by 张亚峰 on 2018/8/29.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

class ZYFEmoticonManager {
    //为了便于表情的复用，建立一个单例，只加载一次表情数据
    // 表情管理器的单例
    static let shared = ZYFEmoticonManager()
    //表情包的懒加载数组
    lazy var packages = [ZYFEmoticonPackage]()
    
    //构造函数，如果在 init 之前增加 private 修饰符，可以要求调用者必须通过 shared 访问对象
    private init () {
        loadPackages()
    }
    
}

// MARK: - 表情符号的处理
extension ZYFEmoticonManager {
    
    /// 将给定的字符串转换成属性文本
    /// 关键点要按照匹配的结果倒叙替换属性文本
    /// - Parameter string: 完整的字符串
    /// - Returns: 属性文本
    func emoticonString(string: String, font: UIFont) -> NSAttributedString {
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
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
        }
        //4. 统一设置一遍字符串的属性
        attrString.addAttributes([NSAttributedStringKey.font : font], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
    //根据 string [爱你] 在所有的表情符号中查找对应的表情模型对象
    
    // - 如果找到了 返回表情模型
    // - 否则返回 nil
    func findEmoticon(string: String) -> ZYFEmoticon? {
        //1.便利表情包
        // OC 中过滤使用 【谓词】
        // swift 中更简单
        for p in packages {
            //2.在表情数组中过滤string
//            let result = p.emoticons.filter { (em) -> Bool in
//                return em.chs == string
//            }
            //方法 - 如果闭包中只有一句，并且是返回
            // 1> 闭包格式定义可以省略
            // 2> 参数省略之后，使用 $0,$1 ... 依次替代原有的参数
            // 3> return 也可以省略
            let result = p.emoticons.filter {  $0.chs == string }
            
            if result.count == 1 {
                return result[0]
            }
        }
        
        return nil
    }
    
}

private extension ZYFEmoticonManager {
    
    func loadPackages()  {
        //读取emoticons.plist
        //只要按照 Bundle 默认的目录结构设定，就可以直接读取 Resources 目录下的文件
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
            let models = NSArray.yy_modelArray(with: ZYFEmoticonPackage.self, json: array) as? [ZYFEmoticonPackage] else {
            return
        }
        
        //设置表情包数据
        //使用 += 不需要再次给 packages 分配空间，直接追加数据
        packages += models
                
    }
}
