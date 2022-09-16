//
//  ContentView.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import SwiftUI



struct ContentView: View {
    
    @State var showAlert : Bool = false
    @State var newTodo : String = ""
    @State var ToDoItems: [String] = []
    let db = DBHelper();
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    if ($ToDoItems.count == 0) {
                        Text("There is nothing to do");
                    } else {
                        ForEach(ToDoItems, id: \.self) { item in
                            ListItemRow(title: item)
                        }.onDelete(perform: delete)
                    }
                    
                }.navigationTitle("Todo")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton();
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") {
                                showAlert = true
                            }.sheet(isPresented: $showAlert,
                                    onDismiss: didDismiss ) {
                                SheetView(showAlert: $showAlert, newTodo: $newTodo, ToDoItems: $ToDoItems)
                                
                            }
                        }
                    }
                
            }
        }
    }
    
    func delete (at offsets: IndexSet) {
        if let first = (offsets.first) {
            ToDoItems.remove(at: first)
        }
    }
    
    func didDismiss () {
        showAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

