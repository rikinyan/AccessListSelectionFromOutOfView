//
//  ViewController.swift
//  AccessListSelectionFromOutOfView
//
//  Created by 力石優武 on 2024/01/01.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var orderListView: OrderListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        orderListView = OrderListView(
            orderList: OrderList(items: []),
            randomAddAction: { [weak self] orderList in
                guard let self else { return orderList }
                return orderList.add(self.randomOrder())
            },
            deleteAction: { orderList, deletedItemIds in
                orderList.delete(deletedItemIds)
            }
        )
        
        let hostingVc = UIHostingController(rootView: orderListView)
        hostingVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hostingVc.view)
        
        let margin = view.layoutMarginsGuide
        hostingVc.view.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        hostingVc.view.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        hostingVc.view.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        hostingVc.view.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
    }

    private func randomOrder() -> Order {
        let menuItem = MenuItem.allCases.shuffled().first!
        return Order(menuItem: menuItem)
    }
}

