//
//  EditPageViewController.swift
//  TheNotebook
//
//  Created by MacStudent on 2018-07-18.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData
class EditPageViewController: UIViewController {
       var myContext:NSManagedObjectContext!
    var page:Page!
    //OUTLETS:
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // set the context
        myContext = appDelegate.persistentContainer.viewContext
        print("edit page ")
        // Do any additional setup after loading the view.
        print("========")
        print(page.text)
        textView.text = page.text!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let y = textView.text!
        self.page.text = y
        do{
            try myContext.save()
        }
        catch
        {
            print("error while saving")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
