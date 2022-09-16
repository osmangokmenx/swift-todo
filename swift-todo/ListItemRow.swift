//
//  ListItemRow.swift
//  swift-todo
//
//  Created by Osman Gökmen on 16.09.2022.
//

import SwiftUI

struct ListItemRow: View {
    let title:String
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
            Text(title)
                .padding()
        }
    }
}

struct ListItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ListItemRow(title: "Test")
    }
}
