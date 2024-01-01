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
    @State var editMode: EditMode = .inactive
    
    var randomAddAction: ((OrderList) -> OrderList)?
    var deleteAction: ((OrderList, Set<UUID>) -> OrderList)?
    
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
            
            HStack {
                if editMode.isEditing == true {
                    Button(action: {
                        guard let newOrderList = deleteAction?(orderList, multiSelections) else { return }
                        orderList = newOrderList
                        editMode = .inactive
                    }) {
                        Text("オーダー削除(\(multiSelections.count)件)")
                    }
                } else {
                    Button(action: {
                        guard let newOrderList = randomAddAction?(orderList) else { return }
                        orderList = newOrderList
                    }) {
                        Text("ランダム追加")
                    }
                }
                Spacer()
                EditButton()
            }
        }
        .environment(\.editMode, $editMode)
    }
}
