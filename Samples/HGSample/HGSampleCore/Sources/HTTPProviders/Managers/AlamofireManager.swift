//
//  AlamofireManager.swift
//  HGSampleCore
//
//  Created by Hg Q. on 10/14/19.
//

import Foundation
import Alamofire
//import Alamofire.Swift


class AlamofireManager: IHTTPManager {
    
    init() {
        print("Initialize AlamofireManager")
    }
    
    // MARK: IHTTPManager

    public func request(_ url: URL, _ method: String, parameters: [String : Any]?, headers: [String : String]?, _ completionHandler: @escaping ((HTTPURLResponse?, Error?) -> Void)) {

        print("\(self): on request")
        var response: DataResponse<Data?, AFError>?
        var _method: HTTPMethod!
        switch method {
        case "GET":
            _method = .get
            break
        case "POST":
            _method = .post
            break
        default:
            _method = .get
            break
        }
        
        let _headers: HTTPHeaders? = (headers != nil) ? HTTPHeaders.init(headers!) : nil
        AF.request(url.absoluteString, method: _method, parameters: parameters, headers: _headers).response { resp in
                response = resp
                completionHandler(response?.response, response?.error)
            }
    }
}
