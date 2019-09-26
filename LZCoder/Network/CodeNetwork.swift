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
    
    
    func fetchData() {
        
       // let request = URLRequest(url: <#T##URL#>)
        //request.http
        
        
        
    }
    
    
    
    func getCodesList(params:Parameters , completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
    
        let username = "lzcoder95@gmail.com"
        let password = "lzcoder123"
        
        
      //  params.forEach { ((key: String, value: Any)) in
      
        
        
        let url = URL(string: "\(Api.BaseUrl)apiFreeText.json")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("username", forHTTPHeaderField: username)
        urlRequest.addValue("password", forHTTPHeaderField: password)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // urlRequest.addValue(, forHTTPHeaderField: <#T##String#>)
        
        
       // urlRequest.addValue(, forHTTPHeaderField: <#T##String#>)
      //  request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
        request(urlRequest).response { (response) in
            
            if let error = response.error {
                print("error fetching data \(error.localizedDescription)")
            }
            
            let str = String(bytes: response.data!, encoding: .utf8)
            
            
            print("response \(str)")
        }
        //request.
        /*
        request(request
             ).responseData { (responseData) in
            guard let data = responseData.data else {return}
             let string = String(bytes: data, encoding: .utf8)
            print("data \(string)")
            completionHandler(responseData)
        }
 */
    }
    
    func getCodesDetails(code:String, completionHandler: @escaping (_ response: DataResponse<Data>) -> Void ) {
        request("\(Api.BaseUrl)\(code).json", method: .get, headers: httpHeaders()).responseData { (responseData) in
            completionHandler(responseData)
        }
    }

}
