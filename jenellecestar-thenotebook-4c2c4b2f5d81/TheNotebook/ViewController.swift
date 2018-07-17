//
//  ViewController.swift
//  TheNotebook
//
//  Created by MacStudent on 2018-07-16.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData     //import Core Data

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tbNotebookName: UITextField!
    @IBOutlet weak var tbPage: UITextField!
    
    
    // create the context variable
    var myContext:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // set the context
        myContext = appDelegate.persistentContainer.viewContext
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions for the app
    
    @IBAction func addNotebookPressed(_ sender: UIButton) {
        // TODO: Add notebook code goes here
        print("Add Notebook button pressed!")
        
        // VALIDATION
        // -- check if the textbox is empty
        let x = tbNotebookName.text!
        if (x.isEmpty) {
            print("Please give your notebook a name")
            return
        }
        
        let notebook = Notebook(context:myContext)
        notebook.title = tbNotebookName.text!
        notebook.dateCreated = Date()
        
        do {
            try myContext.save()
            print("Notebook saved!")
        }
        catch {
            print("Error saving notebook to database")
        }
        
        
    }
    
    @IBAction func addPagePressed(_ sender: UIButton) {
        
        // LOGIC
        let page = Page(context:myContext)
        page.text = tbPage.text!
        page.dateAdded = Date()

        
        // UI NONSENSE
        let x = tbNotebookName.text!    // get notebook name from UI
        
        // VALIDATION :
        // Check that person put something into the text box
        if (x.isEmpty) {
            print("Please give your notebook a name")
            return
        }
        
        // LOGIC: get the notebook that you want to add the page to
        let n = getNotebook(name:x)
        
        // VALIDATION:
        // Check that the notebook exists
        if (n == nil) {
            print("This notebook doesn't exist. Sorry!")
            return
        }
        
        // LOGIC: associate the page to the notebook
        page.notebook = n
        
        do {
            try myContext.save()
            print("Page saved!")
        }
        catch {
            print("Error saving notebook to database")
        }
        
    }
    
    
    @IBAction func showAllPagesPressed(_ sender: UIButton) {
        
        // ---------get name of notebook
        let x = tbNotebookName.text!    // get notebook name from UI
        
        // VALIDATION :
        // Check that person put something into the text box
        if (x.isEmpty) {
            print("Please give your notebook a name")
            return
        }
        
        // ----------query database
        //   a) make a fetch request on Page object
        let fetchRequest:NSFetchRequest<Page> = Page.fetchRequest()
        
        //   b) add a predicate
        let n = getNotebook(name:x)
        fetchRequest.predicate = NSPredicate(format:"notebook = %@", n!)
        
        //   c) send query to database & get results
        do  {
            let rows = try myContext.fetch(fetchRequest)
            
            // -----------output to terminal
            for row in rows {
                print(row.text!)
                print(row.dateAdded!)
                print("------")
            }
        }
        catch {
            print("Error while getting all pages from database")
        }
        
        
    }
    
    
    
    
    
    /*
    public Notebook getNotebook(String name) {
    
        if (name == "jenelle") {
            return new Notebook()
        }
    
        return null
    }
     */
 
    
    func getNotebook(name:String) -> Notebook? {
        // 1. fetch the notebook with this name from Coredata
        // let fetchRequest:NSFetchRequest<_____> = _____.fetchRequest()
        let fetchRequest:NSFetchRequest<Notebook> = Notebook.fetchRequest()
        
        // 2. add a WHERE to my sql statement
        fetchRequest.predicate = NSPredicate(format: "title = %@", name)
        
        // 3. add a LIMIT
        fetchRequest.fetchLimit = 1
        
        // fetchRequest = SELECT * from Notebook WHERE name = 'swift class' LIMIT 1
        
        
        // 4.  Get the results from the database
        do {
            let rows = try myContext.fetch(fetchRequest)
            
            if (rows.count > 0) {
                print(rows[0].title)
                return rows[0]
            }
            else {
                // no notebooks found that have this name
                return nil
            }
            
        }
        catch {
            print("Error getting from the database")
        }
        
        
        // 2. Return it
        return nil
        
    }
    
    
    
    
}

