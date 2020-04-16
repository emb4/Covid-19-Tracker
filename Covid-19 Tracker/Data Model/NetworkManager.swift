//
//  NetworkManager.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation



class NetworkManager: ObservableObject {
    
    @Published var global = Global()
    @Published var items = [Country]()
    @Published var detailItems = DetailItem()
    @Published var caseData = [0.0]
    @Published var recoveredData = [0.0]
    @Published var deathsData = [0.0]
    
    let dataManager = DataManager()
    
    func getGlobal() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SummaryResults.self, from: safeData)
                            DispatchQueue.main.async {
                                self.global = results.global
                            }
                        } catch {
                            print("Error found in the get global stats function: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getWorldSummary() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SummaryResults.self, from: safeData)
                            DispatchQueue.main.async {
                                print("attempting to remove duplicates")
                                let formattedResults = self.dataManager.formatSummary(with: results.countries)
                                self.items = formattedResults                            }
                        } catch {
                            print("Error found in the getWorldSummary function: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    func getDetailInformation(for country: String) {
        
        for i in 0...2 {
            if i == 0 {
                if let url = URL(string: "https://api.covid19api.com/country/\(country)/status/confirmed") {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (optionalData, response, error) in
                        if error == nil {
                            let decoder = self.newJSONDecoder()
                            if let data = optionalData {
                                do {
                                    let results = try decoder.decode(DetailItem.self, from: data)
                                    DispatchQueue.main.async {
                                        let formattedItems = self.dataManager.formatDetail(with: results)
                                        let dateSortedItems = self.dataManager.sortByDate(with: results)
                                        self.detailItems = formattedItems
                                        self.caseData = dateSortedItems
                                    }
                                } catch {
                                    print("Error found in the getDetailInformation function on first attempt: \(error)")
                                }
                            }
                        }
                    }
                    task.resume()
                }
            }
            else if i == 1 {
                if let url = URL(string: "https://api.covid19api.com/country/\(country)/status/recovered") {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (optionalData, response, error) in
                        if error == nil {
                            let decoder = self.newJSONDecoder()
                            if let data = optionalData {
                                do {
                                    let results = try decoder.decode(DetailItem.self, from: data)
                                    DispatchQueue.main.async {
                                        let dateSortedItems = self.dataManager.sortByDate(with: results)
                                        self.recoveredData = dateSortedItems
                                    }
                                } catch {
                                    print("Error found in the getDetailInformation function on second attempt: \(error)")
                                }
                            }
                        }
                    }
                    task.resume()
                }
            }
            else if i == 2 {
                if let url = URL(string: "https://api.covid19api.com/country/\(country)/status/deaths") {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (optionalData, response, error) in
                        if error == nil {
                            let decoder = self.newJSONDecoder()
                            if let data = optionalData {
                                do {
                                    let results = try decoder.decode(DetailItem.self, from: data)
                                    DispatchQueue.main.async {
                                        let dateSortedItems = self.dataManager.sortByDate(with: results)
                                        self.deathsData = dateSortedItems
                                    }
                                } catch {
                                    print("Error found in the getDetailInformation function on third attempt: \(error)")
                                }
                            }
                        }
                    }
                    task.resume()
                }
            }
        }

    }
}
