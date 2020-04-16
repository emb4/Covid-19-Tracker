//
//  DataManager.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 4/2/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation

struct DataManager {
    
    func formatSummary(with jsonArray: [Country]) -> [Country] {
        var uniqueItems = [Country]()
        for items in jsonArray {
            if !uniqueItems.contains(where: {$0.id == items.id }) {
                uniqueItems.append(items)
            }
        }
        let sortedItems = uniqueItems.sorted( by: {$0.totalConfirmed > $1.totalConfirmed})
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
    
    func sortByDate(with element: DetailItem) -> [Double]{
        var newElement = element
//        while newElement.count > 100 {
//            newElement.removeFirst()
//        }
        let sortedItems = newElement.sorted(by: {$0.date < $1.date})
        var doubles: [Double] = [0.0]
        for items in sortedItems {
            if items.cases != 0 {
                doubles.append(Double(items.cases))
            }
        }
        return doubles
    }
}
