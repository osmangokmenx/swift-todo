//
//  ContentView.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import SwiftUI



struct ContentView: View {
    
    @State private var showAlert : Bool = false
    @State private var newTodo : String = ""
    @State var ToDoItems: [String] = [
        "Swift öğren",
        "Swift Yaz",
        "Swift"
    ]
    
    var body: some View {
        NavigationView {
            
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
                            Button("Add") {
                                showAlert = true
                            }.sheet(isPresented: $showAlert,
                                    onDismiss: didDismiss ) {
                                VStack(alignment: .center, spacing: 27.0) {
                                    Spacer()
                                    
                                    TextField(
                                        "User name (email address)",
                                        text: $newTodo
                                    ).padding().frame(width: 200, height: 40).border(Color.blue).fixedSize()
                                    Button("Save") {
                                        save()
                                    }.padding(.top, 2.0)
                                    Spacer()
                                    
                                }
                                
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
    
    func save () {
        ToDoItems.append(newTodo)
        newTodo = ""
        showAlert = false
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

