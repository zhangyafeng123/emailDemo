//
//  ZYFEmoticonManager.swift
//  emailDemo
//
//  Created by 张亚峰 on 2018/8/29.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import Foundation

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
        
        print(packages)
        
    }
}
