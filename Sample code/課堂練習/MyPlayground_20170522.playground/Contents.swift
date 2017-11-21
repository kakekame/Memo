 //: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//*for loop -> for...in loop
//traditional: for(int = 0; i<100:i++){}
//...means "range", include start and ending. start must included, 1..<100, do not included 100.

var total = 0
for i in 1...100{
    total += i
}
total
// _ means omitted, the variaty would not be use in the loop
total = 0
for _ in 1...100{
    total += 1
}
total
//print("") -> console.log for swift. if need mix obj and others, use print is better. (NSLog can't be complie)
let 便當s = ["雞腿便當","排骨便當","烤肉便當"]

for food in 便當s{
    print("我愛吃\(food)")
}

//use for...in to scan dictionary. (OBJ needs get allkeys before scaning.)
//Dictionary do not have order. -> easy to search
//Array use binary tree(B-tree)
let prices = ["雞腿便當":60,"排骨便當":70,"烤肉便當":80,]

for(food, price) in prices {
    print("\(food)一個\(price)元")
}


//character could dispart string into one word. 
//"c" is a type, means charactoer, one word.
// result = 我 + _ -> 愛 + 我 -> 吃 + 愛我 -> 蘋 + 吃愛我 -> 果 + 蘋吃愛我 -> 果蘋吃愛我
//If know one variation never been nil, could use "", without optional is better.
let str1 = "我愛吃蘋果"
var result = ""
for c in str1.characters {
    result = String(c) + result
}
result

//*for...each

//*switch
//Do not need break. Break is default. If need keep on, use fallthrough.
let input = 3
var result2 = ""
switch input {
case 0:
    result2 = "零"
    fallthrough //carry out
case 1:
    result2 = "壹"
case 2...6:     //suppot range
    result2 = "中間"
case 7,8,9:     //support selecting and dispart
    result2 = "較大"
default:        //default here is necessary.
    result2 = "未知"
}
result2


//switch multiple number at same time
let box = (寬:20, 高:20, 深:10)
switch box {
case let (w,h,d) where w == h && h == d :
    print("正方形")
case let (w,h,d) where w == h && d < h :
    print("扁型")
case let (w,h,d) where w == h && d > h :
    print("柱狀")
default:
    print("未知")
}
 
//*gaurd else
let age = 16
//if 寫法
if age < 18 {
    print("不能開車")
}
//guard, if age >= 18, skip loot to return false, else run loop.
//Better to check condition.
func chec(age:Int) -> Bool{
    guard age >= 18 else{
        print("不能開車...")
        return false
    }
    return true
}
 
//optional type
//after guard let, do not to need unwrap after check if it's nil.
func check2(age:Int?) -> Bool{
    guard let age = age else{   //check nil or not
        print("未知年齡")
        return false
    }
    guard age >= 18 else{       //after check, unwrap is not need
        print("不能開車")
        return false
    }
    return true
}
check2(age:20)

 
//*function
//basic
func test1(){
}
//2 parameter, return -> better
func calculate1(input1:Int, input2:Int) -> Int {
    return input1 + input2
}
//[calculate1WithInput: 3 withInput2:8] -> OBJ
calculate1(input1: 3, input2: 8)    //call, check parameter name
 
// -> ver.3.0 (need to add input1 when call, add _ to ommit)
func calculate2( _ input1:Int, input2:Int) -> Int {
    return input1 + input2
}
calculate2(3, input2: 8)
 
//ommit both parameter name
func calculate3( _ input1:Int, _ input2:Int) -> Int {
return input1 + input2
}
calculate3(3,8)
 
//Different parameter name inside and outside, not necessary
func calculate4( first input1:Int, second input2:Int) -> Int {
return input1 + input2
}
calculate4(first: 3, second: 8)
 
//Parameter with default value
//normal
func 吃東西1(action:String, food:String, taste:String) -> String {
    return action + food + taste
}
吃東西1(action: "我愛吃",food: "雞排",taste: "不加辣")
//with default value
func 吃東西2(action:String, food:String, taste:String = "不加辣") -> String {
return action + food + taste
}
吃東西2(action: "我愛吃",food: "火鍋")
//With all default value
func 吃東西3(action:String = "我愛吃", food:String = "烤肉", taste:String = "不加辣") -> String {
    return action + food + taste
}
吃東西3()
吃東西3(food: "甜不辣", taste: "大辣")
吃東西3(taste: "小辣")
 
 
//Subtitude i, j into function, can't chamge the value. (Clone one set into function, outside will not change when inside change.)
//If need change value inside, add inout and &
var i = 10
var j = 20
func swapInt(in1:inout Int, in2:inout Int){ //add inout
    //parameter will set to one clone and let type
    let tmp = in1
    in1 = in2
    in2 = tmp
}
//& means index
swapInt(in1: &i, in2: &j)                   //add & before

//Return multiple result (with tuple type)
 func calculate5(input1:Int, input2:Int) -> (相加:Int, 相乘:Int) {
    return (input1 + input2, input1 * input2)
}
let result1 = calculate5(input1: 3, input2: 5)
result1.0
result1.1
result1.相加
result1.相乘
 
//Suttitude indefinite numbers parameter
//...means indefinite numbers, and import with a array (constructed with all parameter)
func calculateSum(inputs: Int...) -> Int {
    var sum = 0
    for i in inputs {
        sum += i
    }
    return sum
}
calculateSum(inputs: 1,3,5)
calculateSum(inputs: 1,2)
calculateSum(inputs: 2,4,6,8,10)
 
 
//Declare parameter (could be function)
func simple1(input: Int) -> Int {
    return input * 3
}
let simpleFunc1 = simple1   //Declare func as parameter
// simpleFunc1:(Int) -> Int ,is a type sutitude a Int and return a Int
 
simpleFunc1(3)
 
//function could used as a parameter
//(Int) is func type. Double is return type of the func.
func getRateFunc(years:Int) -> (Int) -> Double {
    func period1year(amount:Int) -> Double{
        return Double(amount) * 1.02
    }
    func period3year(amount:Int) -> Double{
        return Double(amount) * 1.04
    }
    if years <= 1{
        return period1year
    }else{
        return period3year
    }
}
let rateFunc = getRateFunc(years: 2)
rateFunc(10000)     //get a rateFunc and subtitude 10000
 
//function could used as a optional type
func getRateFunc2(years:Int) -> ((Int) -> Double)? {
    func period1year(amount:Int) -> Double{
        return Double(amount) * 1.02
    }
    func period3year(amount:Int) -> Double{
        return Double(amount) * 1.04
    }
    if years <= 1{
        return period1year
    }else if years <= 3{
        return period3year
    }else{
        return nil
    }
}
let rateFunc1 = getRateFunc2(years: 1)
rateFunc1
rateFunc1!(10000)   //optional type, so if sustitude a number, unwrap is necessary.
let rateFunc2 = getRateFunc2(years: 4)
rateFunc2
 

 