//
//  File.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let summaryResults = try? newJSONDecoder().decode(SummaryResults.self, from: jsonData)

// MARK: - SummaryResults
struct SummaryResults: Codable {
    let global: Global
    let countries: [Country]
    let date: String

    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
}

// MARK: - Country
struct Country: Codable, Identifiable, Equatable {
    let country, countryCode, slug: String
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    let date: String
    var id: String {
        return slug
    }

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
}

// MARK: - Global
struct Global: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int

    init() {
        newConfirmed = 1
        newDeaths = 1
        newRecovered = 1
        totalConfirmed = 1
        totalDeaths = 1
        totalRecovered = 1
    }
    
    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}

//struct SummaryResults: Decodable {
//    let Countries: [Country]
//}
//
//struct Country: Decodable, Identifiable, Equatable {
//    var id: String {
//        return Slug
//    }
//
//    let Country: String
//    let Slug: String
//    let NewConfirmed: Int
//    let TotalConfirmed: Int
//    let NewDeaths: Int
//    let TotalDeaths: Int
//    let NewRecovered: Int
//    let TotalRecovered: Int
//}


//struct DetailItemElement: Codable, Identifiable, Hashable {
//    var id: String {
//        return province
//    }
//    let country, province: String
//    let lat, lon: Double
//    let date: Date
//    let cases: Int
//    let status: String
//
//    enum CodingKeys: String, CodingKey {
//        case country = "Country"
//        case province = "Province"
//        case lat = "Lat"
//        case lon = "Lon"
//        case date = "Date"
//        case cases = "Cases"
//        case status = "Status"
//    }
//}
//
//typealias DetailItem = [DetailItemElement]

// MARK: - DetailItemElement
struct DetailItemElement: Codable, Identifiable {
    let country: String
    let countryCode: String
    let province: String?
    let city, cityCode, lat, lon: String?
    let cases: Int
    let status: String
    let date: String
    
    var id: String {
        return province ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case cases = "Cases"
        case status = "Status"
        case date = "Date"
    }
}

typealias DetailItem = [DetailItemElement]


