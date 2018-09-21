//
//  PublicCoureAPI.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/4/19.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

enum PublicCourseAPI {
    case login(param: [String: Any])
    case getHomePublicCourseList(param: [String: Any])
    case getHomeSeriesCourseList(pageNum: Int)
    
}


extension PublicCourseAPI: TargetType {
    var baseURL: URL {
        return URL(string: kbaseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/app/user/login.json"
        case .getHomePublicCourseList:
            return "/app/user/home/index.json"
        case .getHomeSeriesCourseList:
            return "/app/c/courseseries/getcourseseries.json"
        }
    }
    
    var method: Moya.Method {
        
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        
        var parameters: [String: Any] = [:]
        parameters["app_guid"] = kapp_guid
        parameters["version_code"] = kversion_code
        parameters["device_uuid"] = kdevice_uuid
        parameters["dev_type"] = kdev_type
        parameters["app_type"] = kapp_type
        parameters["channel_code"] = kchannel_code
        parameters["version"] = kversion
        parameters["push_channel"] = kpush_channel
        parameters["client_id"] = kclient_id
        parameters["user_token"] = kuser_token
        
        switch self {
        case .login(let param):
            let par = ["password": "e10adc3949ba59abbe56e057f20f883e",
                         "phoneNumber": "18899990015"]
            parameters["data"] = JSON(par)
        case .getHomePublicCourseList(let param):
            parameters = param
        case .getHomeSeriesCourseList(let pageNum):
            parameters["data"] = ["pageNum": pageNum]
        }
        print(path)
        print("commParam = \(parameters)")
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
