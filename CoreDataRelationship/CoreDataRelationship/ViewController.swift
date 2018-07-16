//
//  ViewController.swift
//  CoreDataRelationship
//
//  Created by MacStudent on 2018-07-16.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
    @IBOutlet weak var NotebookText: UITextField!
    
    @IBOutlet weak var tbPage: UITextField!
    // create the context variable
    var context : NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
       context = appDelegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addNotebookPressed(_ sender: UIButton) {
        print("clicked")
        //VALIDATION
        let x = NotebookText.text!
        if(x.isEmpty)
        {
            print("enter something")
            return
        }
        let notebook = Notebook(context: context)
        notebook.title = NotebookText.text!
        notebook.dateCreated = Date()
        
        do{
            try context?.save()
            print("NOTEBOOK SAVED")
        }
        catch {
            print("error saving to databse")
        }
        
    }
    
    @IBAction func addPagePressed(_ sender: UIButton) {
        let page = Page(context: context)
        page.text = tbPage.text!
        page.dateAdded = Date()
        
        
        //GET THE NOTEBOOK IN WHICH U WANT TO ADD PAGE
        let x = NotebookText.text!
        //validation
        if(x.isEmpty)
        {
            print("Please enetr the notebook name")
            return
        }
        let n = getNotebook(name: x)
        
        //validation check the notebook exits
        if(n == nil)
        {
            print("this notebook does not exists")
            return
        }
        //associate the page to notebook
       
        page.notebooks = n
        do{
            try context.save()
            print("saved")
        }
        catch{
            print("error saving to notebook")
        }
    }
    
    func getNotebook(name:String) -> Notebook?
    {
        //fetch notebookk with its name from coredata
        let fetchRequest : NSFetchRequest<Notebook> = Notebook.fetchRequest()
        //add a WHERE clause to sql statement
        fetchRequest.predicate = NSPredicate(format: "title = %@", name)
        //add a Limit
        fetchRequest.fetchLimit = 1
        do{
            
           let rows = try context.fetch(fetchRequest)
            if(rows.count > 0)
            {
                print(rows[0].title)
                return rows[0]
            }
            else
            {
           return nil
            }
        }
            catch {
                print("error getting from database")
            }
        
    return nil
    }
    @IBAction func showAllPages(_ sender: UIButton) {
        //getting the name of the notebook
        let x = NotebookText.text!
        //validation
        if(x.isEmpty)
        {
            print("Please enetr the notebook name")
            return
        }
      let n = getNotebook(name: x)
        let fetchRequest : NSFetchRequest<Page> = Page.fetchRequest()
        //add a WHERE clause to sql statement
        fetchRequest.predicate = NSPredicate(format: "notebooks = %@", n!)
        //send query to database
        do{
        let rows = try context.fetch(fetchRequest)
            for row in rows{
              print(row.text!)
                print(row.dateAdded)
                print("=============")
            }
        }
        catch{
            print("error while fetching the pages")
        }
    }
}

