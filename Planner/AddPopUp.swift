//
//  AddPopUp.swift
//  Planner
//
//  Created by Sandy Lee on 11/18/22.
//

import SwiftUI

enum ItemType: Int, Codable, CaseIterable  {
    case Task
    case Selfcare
    
    var itemName: String {
        switch self {
        case .Task: return "Task"
        case .Selfcare: return "Selfcare"
        }
    }
    
    var itemCategory: String {
        switch self {
        case .Task: return "Category"
        case .Selfcare: return "Emojis"
        }
    }
}

//enum Category: Int, Codable, CaseIterable {
//    case purple
//    case pink
//    case green
//    case blue
//
//    var categoryName: String {
//        switch self {
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

enum ColorSet: String, Codable, CaseIterable {
    case purple
    case pink
    case blue
    case tile

    var color: String {
        rawValue
    }
    
    var colorName: String {
        switch self {
        case .purple: return "School"
        case .pink: return "Work"
        case .blue: return "Household"
        case .tile: return "Exercise"
        }
    }
}

enum Emoji: Int, Codable, CaseIterable {
    case 🥰
    case 😴
    case 🧋
    
    var emojiName: String {
        switch self {
        case .🥰: return "🥰"
        case .😴: return "😴"
        case .🧋: return "🧋"
        }
    }
    
    var emojiDetails: String {
        switch self {
        case .🥰: return "date"
        case .😴: return "rest"
        case .🧋: return "dessert treat"
        }
    }
}

struct AddPopUp: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var taskDate = Date()
    @State var taskStartTime = Date()
    @State var taskEndTime = Date()
    @State var taskName: String = ""
    @State var allDay: Bool = false
    @State var item: ItemType = .Task
    @State var emoji: Emoji = .🥰
    @State var selectedColor: ColorSet = .pink
    
    
    var body : some View {
        VStack{
            HStack{
                Button("Cancel", role: .cancel){
                    dismiss()
                }
                .foregroundColor(.red)
                .frame(alignment: .leading)
                Spacer()
                Button("Add"){
                    guard self.taskName != "" else {return}
                    let newTask = TaskItem(context: viewContext)
                    newTask.name = self.taskName
                    newTask.date = self.taskDate
                    newTask.allday = self.allDay
                    newTask.start = self.taskStartTime
                    newTask.end = self.taskEndTime
                    newTask.color = self.selectedColor.rawValue
                    newTask.id = UUID()
                    
                    do{
                        try viewContext.save()
                        print("Task saved.")
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                .frame(alignment: .trailing)
            }
            .padding(.top)
            Picker("Choose item to add", selection: $item){
                ForEach(ItemType.allCases, id: \.self) { item in
                    Text("\(item.itemName)")
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top)
            TextField("\(item.itemName) Name", text: $taskName)
                .textFieldStyle(.plain)
                .padding(.top)
                .disableAutocorrection(true)
                .font(.title2)
                .cornerRadius(5)
            HStack {
                    DatePicker("Date", selection: $taskDate, in: Date()..., displayedComponents: .date)
                    Toggle(isOn: $allDay){
                        Text("All-day")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.top)
            HStack {
                    HStack(spacing: 6){
                        Text("Start")
                        DatePicker("Start time", selection: $taskStartTime, in: Date()..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Spacer()
                    HStack(spacing: 6){
                        Text("End")
                        DatePicker("End time", selection: $taskEndTime, in: Date()..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
            }
            .padding(.top)
            
            HStack(){
                if (item.rawValue == 0) {
                    Text("\(item.itemCategory)")
                    Menu {
                            ForEach(ColorSet.allCases, id: \.self) {item in HStack {
                                Button{
                                    selectedColor = item.self
                                } label: {Label("\(item.colorName)", systemImage: "circle.fill")}
                            }
                            }
                        }
                    label: {
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("\(selectedColor.color)"))
                            Text("\(selectedColor.colorName)")
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.black)
                        }
                    }
                } else if (item.rawValue == 1) {
                    Text("\(item.itemCategory)")
                    Picker("\(item.itemCategory)", selection: $emoji){
                        ForEach(Emoji.allCases, id :\.self){ item in HStack {
                            Text("\(item.emojiName) \(item.emojiDetails)")
                        }.tag(item.emojiName)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
}
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
        }
    }
}

struct AddPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AddPopUp().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
