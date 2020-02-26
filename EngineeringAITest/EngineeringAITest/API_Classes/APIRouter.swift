//
//  APIRouter.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
}

enum APIRouter: Routable {
    case getListData(Int)
}

extension APIRouter {
    var path: String {
        var endPoint = ""
        switch self {
        case .getListData(let page):
            endPoint = "page=\(page)"
        }
        return "https://hn.algolia.com/api/v1/search_by_date?tags=story&" + endPoint
    }
}

extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getListData:
            return .get
        }
    }
}

extension APIRouter {
    var parameters: Parameters? {
        switch self {
        case .getListData:
            return nil
        }
    }
}
