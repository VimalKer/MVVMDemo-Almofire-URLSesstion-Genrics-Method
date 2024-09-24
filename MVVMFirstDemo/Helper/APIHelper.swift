//
//  APIHelper.swift
//  MVVMFirstDemo
//
//  Created by Apple on 23/09/24.
//

//MARK: --> Notes
//TODO: - 'singleon Design Pattent' <-- class object create outside of the class and use property,functions
//TODO: - 'Singleton Design Pattern' <-- class object create inside of the class and use property,functions
//TODO: - Use 'init()' closure by default -- if use it private init() then it will not create object outside of class,
//we also use parameter init(name:string)


//TODO: - 'Inheritance' Concept User Superclass property in subclaas
//TODO: - 'final' keyword if we use class it can not Inherit
//TODO: - 'static' keyword  -> We can use without Object class property
//TODO: -  'genrics' use (like genric api trend) --> Future it will use by you in genric there are any type we will use
//like in function parameter and some cases 'Comparable' protocol called there is some compare two values
//TODO: -  guard statment use and check
//TODO: - '~=' Range pattent matching operator You can use the "pattern-match" operator ~=:
//TODO: - 'do catch' use 'decode' it will throws runtime if any error it will use catch block it will not crash
//TODO: - 'JSONDecoder()' it will convert data to Model(array) --> previous use swifyJson
//TODO: - 'completion: @escaping()' -  use because when api call it will check first internet speed completion run
//in background so it will exit function and return in function it will not line by line execute so use  @escaping()
//it will capture in memory function exit ke bad
  
//TODO: - 'resume()' -  use resume when function exit without data so need to resume so when we need to use
//completion we use resume it will resume calling
//TODO: -  Result() -> use It will return either success(data we send) / failure(error message we send)
//TODO: -  'typealias' -> using exsting datatype we can name it we use only bigType

//TODO: - Calling the Api using Genrics and It will be use for all Module

/*
class A: APIHelper{
 
     func getDatas() {
         var arrData  = APIHelper.sharedInstance.arr
    }
}
*/

//typealias handler = (Result<[ProductDataModel], DataError>) -> Void

//MARK: - Genrics Type handler
typealias handler<T> = (Result<T, DataError>) -> Void
typealias Vimal =  String
 
//TODO: - Singleton Design Pattern -  can not create class Object outside of class
import UIKit

final class APIHelper{
    
    static let sharedInstance =  APIHelper()
    var arr = [String]() //  not use this only leran inheritance
    var firstName : Vimal? // not use this only learn typealias
    private init(){}
    
    //TODO: - Genrics API calling for all Module this can be use
    func requestAPI<T:Decodable>(
        modelType: T.Type,
        moduletype :EndPointType,
        method: HTTPMethods,
        completion: @escaping handler<T>
    ){
        guard let url = moduletype.url else {
            completion(.failure(.invalidURL))
            return
        }
        //MARK: - Background Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,error == nil else {
                completion(.failure(.invalideData))
                return
            }
            guard let response =  response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let arrProduct  =  try JSONDecoder().decode(modelType, from: data)
                completion(.success(arrProduct))
            }catch{
                completion(.failure(.message(error)))
            }
            
        }.resume()
        print("Ending")
    }
    
    /*
    func getProductApiCall(completion: @escaping handler){
        guard let url = URL(string: Constants.GETAPI.productURL) else {
            completion(.failure(.invalidURL))
            return
        }
        //MARK: - Background Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,error == nil else {
                completion(.failure(.invalideData))
                return
            }
            guard let response =  response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let arrProduct  =  try JSONDecoder().decode([ProductDataModel].self, from: data)
                completion(.success(arrProduct))
            }catch{
                completion(.failure(.message(error)))
            }
            
        }.resume()
        print("Ending")
    }
     */
}
//MARK: - Customazation Error Enum
enum DataError: Error{
    case invalidResponse
    case invalidURL
    case invalideData
    case message(_ error :Error?)
}
