//
//  BaseNetworking.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 07/09/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import Alamofire

struct Api {
    static let BaseUrl = "https://www.text2codes.com/T2C/home2api/"
}

class BaseNetworking {
    
    var headers: HTTPHeaders = [:]
    
    func httpHeaders() -> HTTPHeaders{
        let user = "dhaneshgosai@gmail.com"
        let password = "Bdgosai@0622"
        let credentialData = "\(user):\(password)".data(using: .utf8)
        let base64Credentials = credentialData?.base64EncodedString()
        headers = ["Authorization": "Basic \(base64Credentials)"]
        return headers
    }

}
