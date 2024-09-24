//
//  ProductDataModel.swift
//  MVVMFirstDemo
//
//  Created by Apple on 23/09/24.
//

import Foundation

//MARK: - ProductDataModel
struct ProductDataModel : Decodable{
    
    let id: Int!
    let title  :String!
    let price :Float!
    let description :String!
    let category:String!
    let image :String!
    var rating:Rating
}
struct Rating : Decodable{
    var rate :Double!
    let count :Int!
}
