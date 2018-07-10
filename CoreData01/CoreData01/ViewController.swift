//
//  ViewController.swift
//  CoreData01
//
//  Created by MacStudent on 2018-07-10.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //1.create a cariable that allows u to interact with core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let manageContext = appDelegate.persistentContainer.viewContext
        //2.create a row in the table
        //2a. which table u wannna interact
        let userentity = NSEntityDescription.entity(forEntityName: "User", in: manageContext)!
        //2b.create row in table
        //--create new object
        let user =  NSManagedObject(entity: userentity, insertInto: manageContext)
        //--set the properties of object
        user.setValue("HK", forKey: "name")
        user.setValue("HK@gmail.com", forKey: "email")
        user.setValue(1, forKey: "kids")
        //make a date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.date(from: "09-08-1997")
        user.setValue(date, forKey: "birthday")
        print(user)
        //3.save the row to table
        do{
        try manageContext.save()
        }
        catch{
            print("problem saving to database")
        }
        print("saved")
        //4.show
        //4a. create a select * from user
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //4b. run the sql
        do{
            let users = try  manageContext.fetch(userFetch)
            print(users)
        }
        catch{
            print("error while fetching")
        }
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

