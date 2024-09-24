//
//  ProductViewModel.swift
//  MVVMFirstDemo
//
//  Created by Apple on 23/09/24.
//

import Foundation

final class ProductViewModel{
    
    var arrProductModel:[ProductDataModel]  = []
    var eventHandler: ((_ event:Event) -> Void)?  //DATA Binding Using Closure Approch
    
    //MARK: - Using Genrics Get API calling
    func fetchProduct(){
        APIHelper.sharedInstance.requestAPI(
            modelType: [ProductDataModel].self,
            moduletype: EndpointItems.product,
            method: .get) { response in
                self.eventHandler?(.stopLoading)
                switch response{
                case .success(let data):
                    self.arrProductModel = data
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    print(error)
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    //MARK: - Simple API calling
    /*
    func fetchProduct(){
        self.eventHandler?(.loading)
        APIHelper.sharedInstance.getProductApiCall{ response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let data):
                self.arrProductModel = data
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
     */
}
//MARK: - Events Enum
extension ProductViewModel{
    
    enum Event{
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
