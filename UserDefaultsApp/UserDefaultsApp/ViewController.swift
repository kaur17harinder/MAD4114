//
//  ViewController.swift
//  UserDefaultsApp
//
//  Created by MacStudent on 2018-07-09.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //key value pair
        //1.tell ios u want to  use user defaults(local storage)
        let defaults = UserDefaults.standard
       // print(defaults)
        //show what is in the dictionary
       // print(defaults.dictionaryRepresentation())
        //2.add something to user defaults
        //string
        defaults.set("HK", forKey: "person")
        //boolean
        defaults.set(true, forKey: "student")
        //double
         defaults.set(7867.45, forKey: "fees")
        
        //array
        let courseTaken = ["ios", "android" , "swift"]
        defaults.set(courseTaken, forKey: "courses")
        
        //dictionary
        let student = ["name": "HK", "id": "c0123456", "program": "madt"]
        defaults.set(student, forKey: "info")
        
        //3.print user defaults
        print(defaults.dictionaryRepresentation())
        
        print("============")
        //print specific thing
        let x = defaults.double(forKey: "fees")
        print(x)
        
        print("Student?")
        print(defaults.bool(forKey: "student"))
        
         print("Student Name")
        let name = defaults.string(forKey: "person")
        print(name!)
        
         print("course taken")
        let c = defaults.array(forKey: "courses") as! [String]
        print(c)
        
        print("student data")
        let d = defaults.dictionary(forKey: "info") as! Dictionary<String,String>
        print(d)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

