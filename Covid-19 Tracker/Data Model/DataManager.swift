//
//  DataManager.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 4/2/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation

struct DataManager {

    func formatSummary(with jsonArray: [SummaryItem]) -> [SummaryItem] {
        var uniqueItems = [SummaryItem]()
        for items in jsonArray {
            if !uniqueItems.contains(where: {$0.id == items.id }) {
                uniqueItems.append(items)
            }
        }
        let sortedItems = uniqueItems.sorted( by: {$0.TotalConfirmed > $1.TotalConfirmed})
        return sortedItems
    }
    
    func formatDetail(with element: DetailItem) -> DetailItem {
        var uniqueItems = DetailItem()
        for items in element {
            if !uniqueItems.contains(where: {$0.id == items.id }) {
                uniqueItems.append(items)
            }
        }
        let sortedItems = uniqueItems.sorted( by: {$0.cases > $1.cases})
        return sortedItems
    }
}
