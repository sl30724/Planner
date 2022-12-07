//
//  TaskItem+CoreDataProperties.swift
//  Planner
//
//  Created by Sandy Lee on 11/28/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var allday: Bool
    @NSManaged public var color: String
    @NSManaged public var date: Date
    @NSManaged public var done: Bool
    @NSManaged public var end: Date
    @NSManaged public var name: String
    @NSManaged public var start: Date
    @NSManaged public var id: UUID?
    
}

extension TaskItem : Identifiable {

}
