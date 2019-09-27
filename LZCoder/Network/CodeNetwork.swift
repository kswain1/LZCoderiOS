//
//  CodeNetwork.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 07/09/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CodeNetwork: BaseNetworking {
    
    func getCodesList(params:Parameters , completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        request("\(Api.BaseUrl)apiFreeText.json", method: .post, parameters: params, headers: httpHeaders()).validate().responseData { (responseData) in
            let str = String(bytes: responseData.data!, encoding: .utf8)
            print("post", str)
            completionHandler(responseData)
        }
    }
    
    func getCodesDetails(code:String, completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        request("\(Api.BaseUrl)\(code).json", method: .get, headers: httpHeaders()).responseData { (responseData) in
            completionHandler(responseData)
        }
    }
    
    func getApiSinglePhrase(code: String, completionHandler: @escaping([String?]) -> Void){
        request("\(Api.BaseUrl)/apiSinglePhrase\(code).json", method: .post, headers: httpHeaders()).responseJSON { response in
            guard response.result.isSuccess,
                let value = response.result.value else {
                    print("Error while fetching results", response.result.value)
                    completionHandler(["Nil"])
                    return
            }
            // 3 step
            let codeResponse = JSON(value).stringValue
            completionHandler([codeResponse])
            
        }
        
        request("\(Api.BaseUrl)/apiSinglePhrase/lapcholecy.json", method: .get ).authenticate(user: "lzcoder95@gmail.com", password: "lzcoder123").responseJSON {response in
            if response != nil{
                
                let str = String(bytes: response.data!, encoding: .utf8)
                print(str)
            }else {
                print("authentication check", response.data)
            }
        }

    }

}
