//
//  FoodModel.swift
//  AccessListSelectionFromOutOfView
//
//  Created by 力石優武 on 2024/01/01.
//

import Foundation

enum MenuItem: CaseIterable {
    case ramen
    case friedRice
    case chineseDumpling
    
    var name: String {
        switch self {
        case .ramen:
            "ラーメン"
        case .friedRice:
            "チャーハン"
        case .chineseDumpling:
            "餃子"
        }
    }
    
    var price: Int {
        switch self {
        case .ramen:
            800
        case .friedRice:
            700
        case .chineseDumpling:
            600
        }
    }
    
    var priceString: String {
        "¥\(price)"
    }
}

struct Order: Identifiable {
    let id = UUID()
    let menuItem: MenuItem
}

struct OrderList {
    let items: [Order]
    
    func add(_ order: Order) -> OrderList {
        OrderList(
            items: items + [order]
        )
    }
    
    func delete(_ indice: Set<UUID>) -> OrderList {
        let newItems = items
            .filter { item in
                !indice.contains(item.id)
            }
        
        return OrderList(items: newItems)
    }
}
