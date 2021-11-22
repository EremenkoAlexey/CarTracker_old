//
//  TempLib.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.10.2021.
//

import SwiftUI

struct SelectionCell: View {
    
    let item: String
    @Binding var selectedItem: String?
    
    var body: some View {
        HStack {
            Text(item)
            Spacer()
            if item == selectedItem {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }.contentShape(Rectangle())
            .onTapGesture {
                self.selectedItem = self.item
            }
    }
}


struct SelectionList: View{
    var placeHolder: String
    var prompt: String
    var dictionary: [String]
    @Binding var field: String?

    var body: some View{
        Section(header: Text(placeHolder), footer: Text(prompt)) {
            List(dictionary, id: \.self) {item in
                SelectionCell(item: item, selectedItem: $field)
            }
        }
    }
}
