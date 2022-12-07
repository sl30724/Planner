//
//  EditView.swift
//  Planner
//
//  Created by Sandy Lee on 11/30/22.
//
//
//import SwiftUI
//
//struct EditView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) var dismiss
//    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: [])
//    var tasks: FetchedResults<TaskItem>
//    let timeFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "HH:mm"
//        return formatter
//    }()
//    let dateFormatter: DateFormatter = {
//        let formatter1 = DateFormatter()
//        formatter1.locale = Locale(identifier: "en_US_POSIX")
//        formatter1.dateFormat = "MMM d"
//        return formatter1
//    }()
//    
//    var task: TaskItem
//    var ogTitle: String = task.name
//    var ogDate: Date = task.date
//    var ogStart: Date
//    var ogEnd: Date
//    
//    @State private var newTitle = ""
//    @State private var newDate: Date
//    @State private var newStart: Date
//    @State private var newEnd: Date
//    @State private var startTimePicker = false
//    @State private var endTimePicker = false
//    @State private var dateDatePicker = false
//    
//    var body: some View {
//        VStack{
//            HStack{
//                Button("Cancel", role: .cancel){
//                    dismiss()
//                }
//                .foregroundColor(.red)
//                .frame(alignment: .leading)
//                Spacer()
//                Button("Save Changes"){
//                    do{
//                        try viewContext.save()
//                        print("Task saved.")
//                        dismiss()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//                .frame(alignment: .trailing)
//            }
//            .padding(.top)
//            
//            TextField("\(ogTitle)", text: $newTitle)
//                .textFieldStyle(.plain)
//                .padding(.top)
//                .disableAutocorrection(true)
//                .font(.title2)
//                .cornerRadius(5)
//            DatePicker("\(ogDate)", selection: $newDate, in: Date()..., displayedComponents: .date)
//                .padding(.top)
//            HStack {
//                HStack(spacing: 6){
//                    Text("Start")
//                    DatePicker("\(ogStart)", selection: $newStart, in: Date()..., displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                }
//                Spacer()
//                HStack(spacing: 6){
//                    Text("End")
//                    DatePicker("\(ogEnd)", selection: $newEnd, in: Date()..., displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                }
//            }
//            .padding(.top)
//            
//            Menu{
//                Button(action: delete, label: Label("Delete task", systemImage: "trash"))
//                Button(action: save, label: Label("Saved"))
//            }
//            
//        }
//    }
//}
//
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
