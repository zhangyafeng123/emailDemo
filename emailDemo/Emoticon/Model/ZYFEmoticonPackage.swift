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
    @objc var directory: String?
    // 懒加载的表情模型空数组
    // 使用懒加载可以避免后续的解包
    @objc lazy var emoticons = [ZYFEmoticon]()
    
    @objc override var description: String {
        return yy_modelDescription()
    }
}
