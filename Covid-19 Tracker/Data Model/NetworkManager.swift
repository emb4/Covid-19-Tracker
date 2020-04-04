//
//  NetworkManager.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var items = [SummaryItem]()
    @Published var detailItems = DetailItem()
    let dataManager = DataManager()
    
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
//                                self.items = results.Countries.sorted( by: {$0.TotalConfirmed > $1.TotalConfirmed})
                                print("attempting to remove duplicates")
                                let formattedResults = self.dataManager.formatSummary(with: results.Countries)
                                self.items = formattedResults
                            }
                        } catch {
                            print(error)
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
        if let url = URL(string: "https://api.covid19api.com/country/\(country)/status/confirmed") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (optionalData, response, error) in
                if error == nil {
                    let decoder = self.newJSONDecoder()
                    if let data = optionalData {
                        do {
                            let results = try decoder.decode(DetailItem.self, from: data)
                            DispatchQueue.main.async {
//                                self.detailItems = results.sorted( by: {$0.cases > $1.cases})
                                let formattedItems = self.dataManager.formatDetail(with: results)
                                self.detailItems = formattedItems
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
