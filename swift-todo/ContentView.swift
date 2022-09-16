//
//  ContentView.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert : Bool = false
    
    @State var ToDoItems: [String] = [
        "Swift öğren",
        "Swift Yaz",
        "Swift"
    ]
    var body: some View {
        VStack {
            List {
                ForEach(ToDoItems, id: \.self) { item in
                    ListItemRow(title: item)
                }.onDelete(perform: delete)
                
            } .navigationTitle("Todo")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton();
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Tap to show alert") {
                            showAlert = true
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Current Location Not Available"),
                                message: Text("Your current location can’t be " +
                                            "determined at this time.")
                            )
                        }
                        //                        NavigationLink("add", destination: Text("asd"))
                        
                    }
                }
        }
    }
    func delete (at offsets: IndexSet) {
        if let first = (offsets.first) {
            ToDoItems.remove(at: first)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

