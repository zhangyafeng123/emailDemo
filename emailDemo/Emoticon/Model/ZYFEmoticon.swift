//
//  ZYFEmoticon.swift
//  emailDemo
//
//  Created by linjianguo on 2018/8/30.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit
import YYModel
class ZYFEmoticon: NSObject {
    // 表情类型 false - 图片表情 / true - emoji
    @objc var type = false
    // 表情字符串，发送给新浪微博的服务器(节约流量)
    @objc var chs: String?
    // 表情图片名称，用于本地图文混排
    @objc var png: String?
    // emoji 的十六进制编码
    @objc var code: String?
    
    @objc override var description: String {
        return yy_modelDescription()
    }
    
    
}
