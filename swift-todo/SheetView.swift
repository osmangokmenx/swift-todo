//
//  SheetView.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import SwiftUI

struct SheetView: View {
    @Binding var showAlert : Bool
    @Binding var newTodo : String
    @Binding var ToDoItems: [String]
    var body: some View {
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
    
    func save () {
        ToDoItems.append(newTodo)
        newTodo = ""
        showAlert = false
    }
    
}
