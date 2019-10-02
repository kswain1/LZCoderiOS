//
//  CodeNetwork.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 07/09/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import Alamofire

class CodeNetwork: BaseNetworking {
    
    func getCodesList(params:Parameters , completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        request("\(Api.BaseUrl)apiFreeText.json", method: .post, parameters: params, headers: httpHeaders()).responseData { (responseData) in
            completionHandler(responseData)
        }
    }
    
    func getSearchCodesList(searchText:String, params:Parameters , completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        let searchTextEcode = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        request("\(Api.BaseUrl)apiSinglePhrase/\(searchTextEcode).json", method: .get, parameters: params, headers: httpHeaders()).responseData { (responseData) in
            completionHandler(responseData)
        }
    }
    
    func getCodesDetails(code:String, completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        request("\(Api.BaseUrl)apiCPTCodeDetails/\(code).json", method: .get, headers: httpHeaders()).responseData { (responseData) in
            completionHandler(responseData)
        }
    }

}
