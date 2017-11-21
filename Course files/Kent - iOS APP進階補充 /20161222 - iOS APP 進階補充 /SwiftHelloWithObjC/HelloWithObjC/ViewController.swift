//
//  ViewController.swift
//  HelloWithObjC
//
//  Created by Kent Liu on 2015/2/8.
//  Copyright (c) 2015年 Kent Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let objc = MyObjCClass()
        
        let result = objc.sayHello()
        let resultDate = objc.date
        
        let alert = UIAlertController(title: result, message: resultDate?.description, preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

