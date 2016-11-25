//
//  ViewController.swift
//  SurJournal
//
//  Created by Vladimir Nevinniy on 11/25/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currentApplication = UIApplication.shared.delegate as! AppDelegate
        
        let contex = currentApplication.persistentContainer.viewContext
        
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


}

