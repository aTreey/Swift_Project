//
//  String+Extension.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/23.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

private let patternTitle = "(?<=title>).*(?=</title)"

extension String {
    /// 传入ulr 解析html对应的标题
    static func parseHTMLTitle(_ urlString: String, completion:@escaping ((String?) -> ())){
        // 转义中文字符
        guard let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlStr) else {
                completion(nil)
                return
        }
        
        DispatchQueue.global().async {
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let range = html.range(of: patternTitle, options: String.CompareOptions.regularExpression, range: html.startIndex..<html.endIndex, locale: nil)
                guard let tempRange = range else {
                    DispatchQueue.main.async(execute: {
                        completion(nil)
                    })
                    return
                }
                let titleStr = html[tempRange]
                DispatchQueue.main.async(execute: {
                    completion(String(titleStr))
                })
            } catch {
                DispatchQueue.main.async(execute: {
                    completion(nil)
                })
            }
        }
    }
}
