//
//  File.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation

struct SummaryResults: Decodable {
    let Countries: [SummaryItem]
}

struct SummaryItem: Decodable, Identifiable, Equatable {
    var id: String {
        return Slug
    }
    
    let Country: String
    let Slug: String
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
}


struct DetailItemElement: Codable, Identifiable, Hashable {
    var id: String {
        return province
    }
    let country, province: String
    let lat, lon: Double
    let date: Date
    let cases: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case province = "Province"
        case lat = "Lat"
        case lon = "Lon"
        case date = "Date"
        case cases = "Cases"
        case status = "Status"
    }
}

typealias DetailItem = [DetailItemElement]





