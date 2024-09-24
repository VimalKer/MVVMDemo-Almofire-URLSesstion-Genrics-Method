//
//  EndPointType.swift
//  MVVMFirstDemo
//
//  Created by Apple on 24/09/24.
//

//TODO: - get only means u can not assign any value

import Foundation

//MARK: - Methods
enum HTTPMethods:String{
    case get    = "GET"
    case post   = "POST"
}

protocol EndPointType{
    var baseURL : String { get }
    var path: String { get }
    var url: URL? { get }
    var method:HTTPMethods { get }
}

//MARK: - Module vise Enum
enum EndpointItems {
    case product  //Module or screen
//    case employee  //Module or screen
//    case salary  //Module or screen
//    case settings  //Module or screen
}

//"https://fakestoreapi.com/products"
extension EndpointItems : EndPointType{
    var baseURL: String {
        return "https://fakestoreapi.com/"
    }
    var path: String {
        switch self {
        case .product:
            return "products"
//        case .employee:
//            return "employee"
//        case .salary:
//            return "salary"
//        case.settings:
//            return "settings"
        }
    }
    var url: URL? {
        print(URL(string: baseURL + path)!)
        return URL(string: baseURL + path)
    }
    var method: HTTPMethods {
        switch self{
//        case .psost:
//            return .post
        default:
            return .get
        }
    }
}
