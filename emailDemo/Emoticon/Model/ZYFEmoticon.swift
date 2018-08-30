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
    //表情模型所在的目录
    @objc var directory: String?
    // `图片`表情对应的图像
    var image: UIImage? {
        
        //判断表情类型
        if type {
            return nil
        }
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path)
            else {
            return nil
        }
        
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
        
    }
    
    /// 将当前的图像转换生成图片的属性文本
    ///
    /// - Parameter font: 字体大小
    /// - Returns: 返回属性文本
    func imageText(font: UIFont) -> NSAttributedString {
        //1.判断图像是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        //2.创建文本附件
        let attachment = NSTextAttachment()
        attachment.image = image
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        //3.返回图片属性文本
        return NSAttributedString(attachment: attachment)
        
    }
    
    @objc override var description: String {
        return yy_modelDescription()
    }
    
    
    
    
    
    
    
    
    
    
}
