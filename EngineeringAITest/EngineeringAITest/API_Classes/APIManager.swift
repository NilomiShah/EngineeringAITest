//
//  APIManager.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    var header = ["Content-Type": "application/json"]
    
    static let shared: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager: SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func apiCallWithModelClass<Model: Codable>(request: APIRouter, model: Model.Type, completion: @escaping(_ status: Bool, _ result: Model?) -> ())  {
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let dictResponse = try decoder.decode(model, from: response.data ?? Data())
                    DispatchQueue.main.async {
                        completion(true, dictResponse)
                    }
                } catch (let parsingError) {
                    print(parsingError)
                    completion(false, nil)
                }
            case .failure(_):
                completion(false, nil)
            }
        }
    }
}
