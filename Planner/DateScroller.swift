//
//  DateScroller.swift
//  Planner
//
//  Created by Sandy Lee on 12/6/22.
//

import SwiftUI

struct DateScroller: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View
    {
        HStack
        {
            Spacer()
            Button(action: moveBack)
            {
                Image(systemName: "arrow.left")
            }
            
            DatePicker(
                "\(dateFormatted())",
                selection: $dateHolder.viewDate,
                displayedComponents: .date
                )
            .frame(maxWidth: .infinity)
            .labelsHidden()
            .font(.headline)
            .padding()
            .environmentObject(dateHolder)
            .onChange(of: dateHolder.viewDate) { newValue in
                dateHolder.refreshTaskItems(viewContext)
            }

            Button(action: moveForward)
            {
                Image(systemName: "arrow.right")
            }
        }
    }
    
    func dateFormatted() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: dateHolder.viewDate)
    }
    
    func moveBack()
    {
        withAnimation
        {
            dateHolder.moveDate(-1, viewContext)
        }
    }
    
    func moveForward()
    {
        withAnimation
        {
            dateHolder.moveDate(1, viewContext)
        }
    }
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}
