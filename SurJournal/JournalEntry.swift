//
//  JournalEntry.swift
//  SurJournal
//
//  Created by Vladimir Nevinniy on 11/28/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import Foundation
import CoreData


extension JournalEntry {
    func stringForDate() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        if let date = self.date {
            return dateFormatter.string(from: date as Date)
        } else {
            return ""
        }
    }
    
    func csv() -> String {
        
        let coalescedHeight = height ?? ""
        let coalescedPeriod = period ?? ""
        let coalescedWind = wind ?? ""
        let coalescedLocation = location ?? ""
        var coalescedRating:String
       
        coalescedRating = String(rating)
        
        return "\(stringForDate()),\(coalescedHeight)," +
            "\(coalescedPeriod),\(coalescedWind)," +
        "\(coalescedLocation),\(coalescedRating)\n"
    }
}
