//
//  ZYFEmoticonPackage.swift
//  emailDemo
//
//  Created by linjianguo on 2018/8/30.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

class ZYFEmoticonPackage: NSObject {
    //表情包的分组名
    @objc var groupName: String?
    //表情包目录，从目录下加载 info.plist 可以创建表情模型数组
    @objc var directory: String? {
        didSet {
            //当设置目录时，从目录下加载 info.plist
            guard let directory = directory,let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String : String]],
                let models = NSArray.yy_modelArray(with: ZYFEmoticon.self, json: array) as? [ZYFEmoticon] else {
                return
            }
           //设置表情模型数组
            emoticons += models
            
        }
    }
    // 懒加载的表情模型空数组
    // 使用懒加载可以避免后续的解包
    @objc lazy var emoticons = [ZYFEmoticon]()
    
    @objc override var description: String {
        return yy_modelDescription()
    }
}
