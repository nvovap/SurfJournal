//
//  JournalListViewController.swift
//  SurJournal
//
//  Created by Vladimir Nevinniy on 11/28/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import CoreData

class JournalListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var coreDataStack: CoreDataStack!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        coreDataStack = CoreDataStack()
        
        
        let contex = coreDataStack.persistentContainer.viewContext
        
        let featchRequest = NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
        
        do {
            let journalEntry = try contex.fetch(featchRequest)
            
            for record in journalEntry {
                print("========================================================================")
                print("Date \(record.date)  height \(record.height) location \(record.location)")
                print("")
                print("period \(record.period)  rating \(record.rating) wind \(record.wind)")
            }
            
        } catch let error {
            print(error)
        }
        
        
        
                let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                print(urls.count)
                let url = urls[urls.count-1]
                print(url)
        
        let count = coreDataStack.persistentContainer.persistentStoreDescriptions.count - 1
        print(coreDataStack.persistentContainer.persistentStoreDescriptions[count])
        
        //        if let url = url {
                    do {
                        let filesInDirectory = try FileManager.default.contentsOfDirectory(atPath: url.path)
        
                        for file in filesInDirectory {
                            print(file)
        
        
                        }
        
                    } catch let error {
                        print(error)
                    }
                    
                //}
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let count = fetchedResultsController.sections?.count ?? 0
        print(count)
        
        return count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        print(count)
        
        return count
    }

    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath) as! SurfEntryTableViewCell
            
            configureCell(cell, indexPath: indexPath)
            
            return cell
    }
    
    func configureCell(_ cell: SurfEntryTableViewCell,
                       indexPath:IndexPath) {
        
        let surfJournalEntry =
            fetchedResultsController.object(at: indexPath)
                
        
        cell.dateLabel.text = surfJournalEntry.stringForDate()
        
        
        switch surfJournalEntry.rating {
            case 1:
                cell.starOneFilledImageView.isHidden = false
                cell.starTwoFilledImageView.isHidden = true
                cell.starThreeFilledImageView.isHidden = true
                cell.starFourFilledImageView.isHidden = true
                cell.starFiveFilledImageView.isHidden = true
            case 2:
                cell.starOneFilledImageView.isHidden = false
                cell.starTwoFilledImageView.isHidden = false
                cell.starThreeFilledImageView.isHidden = true
                cell.starFourFilledImageView.isHidden = true
                cell.starFiveFilledImageView.isHidden = true
            case 3:
                cell.starOneFilledImageView.isHidden = false
                cell.starTwoFilledImageView.isHidden = false
                cell.starThreeFilledImageView.isHidden = false
                cell.starFourFilledImageView.isHidden = true
                cell.starFiveFilledImageView.isHidden = true
            case 4:
                cell.starOneFilledImageView.isHidden = false
                cell.starTwoFilledImageView.isHidden = false
                cell.starThreeFilledImageView.isHidden = false
                cell.starFourFilledImageView.isHidden = false
                cell.starFiveFilledImageView.isHidden = true
            case 5:
                cell.starOneFilledImageView.isHidden = false
                cell.starTwoFilledImageView.isHidden = false
                cell.starThreeFilledImageView.isHidden = false
                cell.starFourFilledImageView.isHidden = false
                cell.starFiveFilledImageView.isHidden = false
            default :
                cell.starOneFilledImageView.isHidden = true
                cell.starTwoFilledImageView.isHidden = true
                cell.starThreeFilledImageView.isHidden = true
                cell.starFourFilledImageView.isHidden = true
                cell.starFiveFilledImageView.isHidden = true
            }
        }
    
    

    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<JournalEntry> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let count = coreDataStack.persistentContainer.persistentStoreDescriptions.count - 1
        print(coreDataStack.persistentContainer.persistentStoreDescriptions[count])
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<JournalEntry>? = nil
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        default:
//            return
//        }
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
     //   case .insert:
      //      tableView.insertRows(at: [newIndexPath!], with: .fade)
     //   case .delete:
      //      tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            //self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! JournalEntry)
            self.configureCell(tableView.cellForRow(at: indexPath!)! as! SurfEntryTableViewCell, indexPath: indexPath!)
            
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default: break
            
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 44;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let surfJournalEntry = fetchedResultsController.object(at: indexPath)
            
            coreDataStack.persistentContainer.viewContext.delete(surfJournalEntry)
            coreDataStack.saveContext()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
