//
//  Habit+CoreDataProperties.swift
//  HabitTraker
//
//  Created by Abduraxmon on 16/04/23.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var days: [Int64]
    @NSManaged public var startingDay: Int64
    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}

extension Habit : Identifiable {

}
