import UIKit

var greeting = "Hello, playground"
print(greeting)

//MARK: - Genrics
//use Comparable for comare G /T any type all type accepted
func lowestNumber<G : Comparable>(a : G,b: G){
    a > b ? print("b is lowest Number") : print("a is lowest number")
}

lowestNumber(a: 50.55, b: 45.00)

func whatTypeIs<T>(Input : T){
 print("The input type is \(type(of: Input))")
}
whatTypeIs(Input: ["Hello":255,"veer":25.55,"sfsd":"sdf"])
