//
//  MySwiftClass.swift
//  HelloObjCWithSwift
//
//  Created by Kent Liu on 2015/2/8.
//  Copyright (c) 2015年 Kent Liu. All rights reserved.
//

import Foundation

class MySwiftClass:NSObject {
    
    var date : Date?
/*
    class func alloc() -> MySwiftClass {
        
        return MySwiftClass()
    }
*/
    func sayHello() -> String {
        
        date = Date()
        
        return "Hello! I come from Swift!"
    }
    
}

