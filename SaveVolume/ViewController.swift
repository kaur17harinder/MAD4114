//
//  ViewController.swift
//  SaveVolume
//
//  Created by robin on 2017-11-08.
//  Copyright © 2017 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //variables
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let x = UserDefaults.standard.float(forKey: "slider")
       print(x)
        slider.value = x
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func volume(_ sender: UISlider) {
        //var defaults = UserDefaults.standard
        print(sender.value)
        UserDefaults.standard.set(sender.value, forKey: "slider")
       print("======")
    }
    
   
    
}

