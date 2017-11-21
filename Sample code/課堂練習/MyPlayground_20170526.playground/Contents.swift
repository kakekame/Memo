//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Basically Class. Could add inherit from and protocol below, but not necessary, not inherit is possible.
//OBJ should set inherit from.
//Class is "kind of" special singleton object. Include instance and class method. Could generate objects by based on it.
class 車子 {
    
    //var, class, func inside could set public, open, internal, private, fileprivate. -> p.40
    
    //Object inside:   1.var   2.func

//    var 品牌 = ""
//    var 型號 = ""
    static var 類別變數 = "456"

    
    private(set) var 引擎號碼 = UUID().uuidString       //Protect value from revise.
    private var 引擎號碼密碼 = "1234"                    //Only could be reconize in this class.
    
    
    //Give a default later. With init is necessary.
    var 品牌:String
    var 型號:String
    
    // () means construtive, alloc and init.
    // Generate car with brand and model parameter.
//    init(brand: String, model: String){
//        品牌 = brand
//        型號 = model
//    }
  
    // Can choose which to sustitude. 4 posible condition(oo/ox/xo/xx), OBJ needs 4 types of construction.
    // 1. Set default value
/*    init(brand:String = "Unknown", model:String = "Unknown"){
        品牌 = brand
        型號 = model
*/    }
    // 2. Convenience construction -> Could not exist byself. It is addition function based on basic init.
    init(brand:String, model:String) {
        品牌 = brand
        型號 = model
    }
    convenience init() {
        self.init(brand:"Unknown", model:"Unknown")
    }

    convenience init(brand:String) {    //Could judgement more complicated condition.
        
        var finalModel:String
        if brand == "TOYOTA"{
            finalModel = "Altis"
        }else if brand == "VW"{
            finalModel = "Golf"
        }else{
            finalModel = "Unknown"
        }
        
        self.init(brand:brand,model:"Unknown")
    }

    convenience init(model:String) {
        self.init(brand:"Unknown",model:model)
    }



    init(品牌: String, 型號: String){   //Multiple init is possible.
        self.品牌 = 品牌    //If variation name repeat and they all assign the same one, Could use self._ to call area variation above.
        self.型號 = 型號
    }

    //Class inside (Inner Class) -> OBJ not support. JAVA support one layer.
    class 引擎 {
        var 排氣量 = 2000
    }
    
    //OBJ: - () func
    func 自我介紹() -> String {             //instance method. Could use only when been created.
        return "大家好，我是\(品牌)的\(型號)"
    }
    
    //OBJ: + () func
    class func 類別方法範例() -> String {    //class methos. Could use only at class.
        return "123" + 類別變數             //class method could use at variation when set as static.
    }
    
    
}

//let car1 = 車子() -> when no parameter
let car1 = 車子(brand: "TOYOTA", model: "Altis")
let car2 = 車子(brand: "TOYOTA")
let car3 = 車子(brand: "Altis")
let car4 = 車子()
car1.品牌 = "VW"
car1.型號 = "Altis"
car1.自我介紹()        //Instance method. Used with object. When car1 has been create, it could use.
車子.類別方法範例()     //Class method. Used with class. Follow the class, object does not matter.

car1.引擎號碼
//car1.引擎號碼 = "banana" -> private(set) could pakaged value, prevent from revise.

//car1.類別變數 -> Not work. If static var already be used in class, it could not be used otherwhere.

let engine1 = 車子.引擎()
engine1.排氣量