//
//  DateHolder.swift
//  Planner
//
//  Created by Sandy Lee on 12/6/22.
//

import SwiftUI
import CoreData


class DateHolder: ObservableObject {
    @Published var viewDate = Date()
    @Published var taskItems: [TaskItem] = []
    
    let calendar: Calendar = Calendar.current
    

    
    func moveDate(_ days: Int,_ context: NSManagedObjectContext)
    {
        viewDate = calendar.date(byAdding: .day, value: days, to: viewDate)!
        refreshTaskItems(context)
    }
    
    init (_ context: NSManagedObjectContext){
                refreshTaskItems(context)
            }
    
    
    func refreshTaskItems(_ context: NSManagedObjectContext){
        taskItems = fetchTaskItems(context)
    }
        

        
    func fetchTaskItems(_ context: NSManagedObjectContext) -> [TaskItem]{
        do {
            return try context.fetch(dailyTasksFetch()) as [TaskItem]
        } catch let error {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func dailyTasksFetch() -> NSFetchRequest<TaskItem> {
        let request = TaskItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TaskItem.start, ascending: true)]
        request.predicate = predicate()
        return request
    }
    
//    private func sortOrder() -> [NSSortDescriptor] {
//        let startTimeSort = NSSortDescriptor(keyPath: \TaskItem.start, ascending: true)
//        
//        return [startTimeSort]
//    }
    
    private func predicate() -> NSPredicate {
        let start = calendar.startOfDay(for: viewDate)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        return NSPredicate(format: "date >=%@ AND date <%@", start as NSDate, end! as NSDate)
    }
    
    func saveContext (_ context: NSManagedObjectContext) {
        do {
            try context.save()
            refreshTaskItems(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
