//: Playground - noun: a place where people can play
//*Only kit needs import. Other object in same project would be imported.
import UIKit

//*declare type is not need.
//var str:String = "Hello, playground", could add type like this, but not necessary.
var str = "Hello, playground"
var number = 123
var floatNumber = 1.23

//declare and initialize at same time,() means alloc init
var button = UIButton()

number += 10

//"let" declare a number(constant) will never alter
let pi = 3.14159

//Give value after declare is legitimate, but still have to do before using.
var number2:Int
number2 = 10

let number4:Int
number4 = 123
let number5 = number4+1

//Calculating in different type is illegal.
let number6 = 123
let double1 = 1.23
//let result1 = number6 * double1 -> not work
//Transfer type. Double -> Int would unconditional rounding, 1.67->1
//Double(A) init a double with A
let result1 = double1 * Double(number6)
let result2 = Int(double1) * number6

//number7++ is illegal, use number7 += 1
// int v1 = 100; int v2 = v1++; result is v2=100, v1=101; v1 adding after using. When v1 is 100, equal to v2; after that, start adding to 101, v1 become 101 in the end.
var number7 = 10
number7 += 1

//Supprt Unicode, String format \(var)
let 🐔 = 3
let 🐰 = 5
let 幾隻腳 = "\(🐔)隻雞加\(🐰)隻兔，合計有\( 🐔 * 2 + 🐰 * 4)隻腳"

//String appending use"+"
let str1 = "午安"
let str2 = "大家好"
let hello = str1 + str2

//String compare
//if([str1 isEqualToString:@"午安"]){}  -> Objective-c
if str1 == "午安"{
}


//Declare nil, optional type -> type+?, pakage nil and type. Declare nil is possible in this case.
//Checking the optional value is nil or not, if not nil, using "!" to unwrap, like str3!. But if is nil, ! will lead to crash. It is important to check.
//Optional type define is nil if not give value.
var str3:String? = "abc"
var str4:String = "def"

if str3 != nil{  //traditional if loop
    let str5 = "你好. \(str3!)"
    //...
}

if let str = str3{  //if let loop. It would check if str3 is nil, skip. If str3 is not nil, unwrap and assign to str, use the new constant run code in the loop.
    let str5 = "你好. \(str)"
    //...
}

//Can't determine condition following.
var age:String? = "20"

//Ternary operation, if "age != nil" is ture, get "age!", or"“未知”"
//let ageToDisPlay = (age != nil ? age! : "未知")
//If age not nil, unwrap and insert value to ageToDispaly. If age nil, insert "未知" to ageToDisplay.
let ageToDispaly = age ?? "未知"
ageToDispaly

let str6 = "你好. \(str4)"

//Optional type adding string, unwrap is necessary, since String and String? is different type.
//Optional chain. Could append multiple string, if any string is nil, all chain would be nil.
var str7:String? = "abc"
str7?.append("ghi")

let str8 = str7!

//String! is also optional type and already unwrap, but needs to check it's not nil.
var str9:String! = "abc"
str9.append("ghi")


//*Tuple, a container could insert multiple type object.
//Calling could use order or give a name
let box1 = (5,4,3,"盒子")
let 體積1 = box1.0 * box1.1 * box1.2
let box2 = (h:5,w:4,d:3,name:"盒子")
let 體積2 = box2.h * box2.w * box2.d
box2.name

//*Array, if out of range will lead to crash.
var 午餐 = ["雞排便當","排骨便當","烤肉便當"]
let 午餐選擇 = "今天午餐吃\(午餐[1])"

午餐.insert("雞腿便當", at:0)
午餐.append("控肉便當")
午餐.remove(at: 1)
//Merg two array is possible.
午餐 += ["滷肉便當"]
//All array could modify, if need unchanging, use "let"
let 午餐2 = ["雞排便當","排骨便當","烤肉便當"]
//Generate an array
var array1 = [String]()
var array2 = Array<String>()
var array3 = [Any]()            //Class object or other object
var arrya4 = [AnyObject]()      //Class object only
var array5 = [AnyClass]()       //Class only: UIButton

array3.append("123")
array3.append(UIViewController())
array3.append(UIViewController())
//array4.append("123")          //Illegel, string is struct, not class object
array5.append(UIViewController.self)
//array5.append("123")          //Illegal, string is struct, not class


//Two-dimensional
var array6 = [[Int]]()
var array7 = Array<Array<Int>>()


//*Dictionary
//Get optional type, but if no value, would get nil but can't crush
var 價目表 = ["雞排便當":60,"排骨便當":70,"烤肉便當":80]
let 午餐多少錢 = "今天午餐\(價目表["雞排便當"])元"

價目表.updateValue(90, forKey: "香腸便當")
價目表["價目表"] = 100    //Also could use this to insrt

//Generate new dictionary
var dictionary1 = [String:Int]()
var dictionary2 = Dictionary<String,Int>()
var dictionary3 = [String:Any]()     //Key must be the same type, value could be any type.


//*Set, no order (dictionary as well)
//compare with symmertirc difference, union, intersection. Could get a new array but won't have duplicate.
let hobby1 = Set(["吃飯","睡覺","打籃球","看電影"])
let hobby2 = Set(["吃飯","打籃球","聽音樂","抓寶可夢"])

hobby1.symmetricDifference(hobby2)          //{"看電影","抓寶可夢","睡覺","聽音樂"}
hobby1.union(hobby2)                        //{"吃飯","打籃球","睡覺","聽音樂","看電影","抓寶可夢"}
hobby1.intersection(hobby2)                 //{"吃飯","打籃球"}

let testNumber = "12234"                    //"12234"
let testSet = Set(testNumber.characters)    //{"4","2","1","3"}, characters could get content inside
testSet.count                               //4



//Logical progrming
//if loop
var number9 = 10
if number9 >= 10 {
    print("...")
}
//if number9 = 3 {...} traditional program use, means give 3 to number9, then check if number9 is zero, zero -> fault, or ture.
if number9 == 3 {
    print("...")
}

//while loop
var total = 0
while total < 100 {
    total += 1
}
total

//do...while loop -> repeat...while, do once then check if accord in condition to do next time.
total = 0
repeat{
    total += 1
}while total < 100
total





