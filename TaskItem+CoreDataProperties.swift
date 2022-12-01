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
//    @NSManaged public var category: Int16
    @NSManaged public var date: Date
    @NSManaged public var done: Bool
    @NSManaged public var end: Date
    @NSManaged public var name: String
    @NSManaged public var start: Date
    @NSManaged public var id: UUID?

//    var taskCategory: Category {
//        set {
//            category = newValue.rawValue
//        }
//        get {
//            Category(rawValue: category) ?? .purple
//        }
//    }
}
extension TaskItem : Identifiable {

}

//public enum Category: Int16, Codable, CaseIterable {
//    case purple
//    case pink
//    case green
//    case blue
//    
//    var categoryName: String {
//        switch self{
//        case .purple: return "purple"
//        case .pink: return "pink"
//        case .green: return "green"
//        case .blue: return "blue"
//        }
//    }
//
//    var categoryColor: Color {
//        switch self {
//        case .purple: return Color.purple
//        case .pink: return Color.pink
//        case .green: return Color.green
//        case .blue: return Color.blue
//        }
//    }
//}
