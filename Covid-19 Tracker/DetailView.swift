//
//  DetailView.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct DetailView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    var dataManager = DataManager()
    
    let country: String
    let slug: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    
    let test = [1.0,2.0,3.0,4.0,5.0,6.0]
    
    var percentageChange: Int {
        return Int((Double(newConfirmed)/Double(totalConfirmed)) * 100)
    }
    
    
    var latitude = 0.0
    var longitude = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    MultiLineChartView(data: [(networkManager.caseData, GradientColors.blue), (networkManager.recoveredData, GradientColors.green), (networkManager.deathsData, GradientColors.orngPink)], title: "", legend: country, rateValue: dataManager.getPercentChanged(newConfirmed: newConfirmed, newRecovered: newRecovered, totalConfirmed: totalConfirmed))
                    //                    Text(country)
                    //                        .font(.title)
                    VStack{
                        if totalConfirmed != 0 {
                            Text("\(totalConfirmed) cases")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6401130557, blue: 0.8553348184, alpha: 0.7543855445)))
                        }
                        if newConfirmed != 0 {
                            Text("+\(newConfirmed) new")
                                .font(.caption)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6401130557, blue: 0.8553348184, alpha: 0.7543855445)))
                        }
                        if totalRecovered != 0 {
                            Text("\(totalRecovered) recovered")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.511287385, blue: 0, alpha: 0.75)))
                        }
                        if newRecovered != 0 {
                            Text("+\(newRecovered) new")
                                .font(.caption)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.511287385, blue: 0, alpha: 0.75)))
                        }
                        if totalDeaths != 0 {
                            Text("\(totalDeaths) deaths")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.75)))
                        }
                        if newDeaths != 0 {
                            Text("+\(newDeaths) new")
                                .font(.caption)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.75)))
                        }
                    }
                }
                Spacer()
                if networkManager.regionInformationIsComplete == true {
                    Spacer()
                    Text("Affected Regions")
                        .font(.title)
                        .opacity(0.50)
                    List(networkManager.detailItems){item in
                        HStack{
                            if item.province != "" {
                                if item.cases == 0 {
                                    Spacer()
                                }
                                Text("\(item.province!)")
                                    .opacity(0.90)
                                if item.cases == 0 {
                                    Spacer()
                                }
                            }
                            if item.cases != 0 {
                                Spacer()
                                Text("\(item.cases) Cases")
                                    .opacity(0.75)
                            }
                        }
                    }
                } else {
                    Text("Region information will show here when available")
                        .font(.caption)
                        .opacity(0.50)
                    Spacer()
                }
                Text("Data from Johns Hopkins CSSE")
                    .font(.system(size: 10))
                    .edgesIgnoringSafeArea(.bottom)
                    .opacity(0.50)
            }
        }
        .onAppear(){
            self.networkManager.getDetailInformation(for: self.slug)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(country: "USA", slug: "us", newConfirmed: 10, totalConfirmed: 5000, newDeaths: 40, totalDeaths: 200, newRecovered: 600, totalRecovered: 800)
    }
}
