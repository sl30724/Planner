//
//  TaskView.swift
//  Planner
//
//  Created by Sandy Lee on 11/18/22.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: [])
    var tasks: FetchedResults<TaskItem>
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    @State private var editSheet = false
    
    var body: some View {
        List{
            ForEach(tasks) { task in
                HStack(alignment: .top, spacing: 20){
                    Image(systemName: task.done ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundColor(task.done ? Color(.darkGray): Color(.systemGray))
                        .onTapGesture {
                            task.done.toggle()
                            do{
                                try viewContext.save()
                                print("Task has been marked as done.")
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    VStack(alignment: .leading, spacing: 8){
                        Text("\(task.name)")
                            .font(.headline)
                        Text("\(task.start, formatter: timeFormatter) - \(task.end, formatter: timeFormatter)")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("edit button expanded")
                        editSheet.toggle()
                    } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16, alignment: .trailing)
                                .foregroundColor(Color.black)
                    }
                }   .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("\(task.color)"))
                    .cornerRadius(10)
            }
            .onDelete(perform: delete)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .listRowBackground(Color.clear)
            .onTapGesture{editSheet.toggle()}
            
        }
        .sheet(isPresented: $editSheet) {
            Text("Edit sheet")
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
                .padding(20)
                .frame(maxHeight: .infinity, alignment: .top)
//                .transition(.offset(y: -40))
        }
    }
    
    func delete(indexs: IndexSet) {
        for index in indexs {
            viewContext.delete(tasks[index])
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
