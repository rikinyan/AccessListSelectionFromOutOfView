//
//  OrderListView.swift
//  AccessListSelectionFromOutOfView
//
//  Created by 力石優武 on 2024/01/01.
//

import SwiftUI

struct OrderListView: View {
    @State var orderList: OrderList
    @State var multiSelections = Set<UUID>()
    @Environment(\.editMode) var editMode
    
    var addAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    var body: some View {
        VStack {
            List(orderList.items, selection: $multiSelections) { item in
                HStack {
                    Text(item.menuItem.name)
                    Spacer()
                    Text("\(item.menuItem.priceString)")
                }
            }
            .listStyle(.plain)
            
            if editMode?.wrappedValue.isEditing == true {
                Button(action: {
                    deleteAction?()
                    editMode?.wrappedValue = .inactive
                }) {
                    Text("オーダー削除(\(multiSelections.count)件)")
                }
            } else {
                Button(action: {
                    addAction?()
                }) {
                    Text("ランダム追加")
                }
            }
        }
        .toolbar {
            EditButton()
        }
    }
}
