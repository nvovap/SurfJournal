//
//  JournalEntry+CoreDataProperties.swift
//  SurJournal
//
//  Created by Vladimir Nevinniy on 11/28/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry");
    }

    @NSManaged public var date: Date?
    @NSManaged public var height: String?
    @NSManaged public var location: String?
    @NSManaged public var period: String?
    @NSManaged public var rating: Int16
    @NSManaged public var wind: String?

}
