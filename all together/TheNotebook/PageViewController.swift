//
//  PageViewController.swift
//  TheNotebook
//
//  Created by MacStudent on 2018-07-17.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData
class PageViewController: UITableViewController {
    // create the context variable
    var myContext:NSManagedObjectContext!
    
     var pages:[Page] = []
     //spot for segue
    var notebookName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print("send by first screen::")
        print(notebookName)
        print("==========")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // set the context
        myContext = appDelegate.persistentContainer.viewContext
        getAllPages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pages.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dont' forget to change "myCell" to whatever you called it in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell1", for: indexPath)
        
        // put some text in each row
        cell.textLabel?.text = pages[indexPath.row].text
        
        return cell
    }

    func getAllPages(){
        
        // ----------query database
        //   a) make a fetch request on Page object
        let fetchRequest:NSFetchRequest<Page> = Page.fetchRequest()
        let x = self.notebookName
        //   b) add a predicate
        let n = getNotebook(name:x)
        fetchRequest.predicate = NSPredicate(format:"notebook = %@", n!)
        
        //   c) send query to database & get results
        do  {
            self.pages = try myContext.fetch(fetchRequest)
            
            // -----------output to terminal
            for row in pages {
                print(row.text!)
                print(row.dateAdded!)
                print("------")
            }
        }
        catch {
            print("Error while getting all pages from database")
        }
        
        
    }
    
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let editPageVC = segue.destination as! EditPageViewController
        //get the row clicked on
          let i = (self.tableView.indexPathForSelectedRow?.row)!
        //get the object array
        let p = pages[i]
        // Pass the selected object to the new view controller.
      editPageVC.page = p
    }


}
