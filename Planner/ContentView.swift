//
//  ContentView.swift
//  Planner
//
//  Created by Sandy Lee on 11/18/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var router = ViewRouter()
//    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack{
            Spacer()
            
            router.view
            
            Spacer()
            
            HStack{
                TabIcon(viewModel: .Tasks, router: router)
                CenterTabIcon()
                TabIcon(viewModel: .CheckIn, router: router)
            }
            .frame(height: UIScreen.main.bounds.height/10)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray5))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(router: ViewRouter())
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct CenterTabIcon: View {
    @State private var SheetShow = false
    var body: some View{
        Button {
            print("Sheet expanded")
            SheetShow.toggle()
        } label: {
            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .shadow(radius: 4)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.systemBlue))
            }
        }
        .offset(y: -40)
        .sheet(isPresented: $SheetShow) {
            AddPopUp()
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
                .padding(20)
                .frame(maxHeight: .infinity, alignment: .top)
                .transition(.offset(y: -40))
        }
    }
}

struct TabIcon: View {
    let viewModel: TabBarViewModel
    @ObservedObject var router = ViewRouter()
    var body: some View {
        Spacer()
        Button {
            router.currentView = viewModel
        } label: {
            VStack(spacing: 5){
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                Text("\(viewModel.tabTitle)")
                    .font(.callout)
            }
        }
        Spacer()
    }
}
