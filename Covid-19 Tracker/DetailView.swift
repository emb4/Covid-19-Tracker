//
//  DetailView.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    let country: String
    let slug: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    
    var latitude = 0.0
    var longitude = 0.0
    
    let mapView = MapView()
        
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    MapView()
                        .frame(width: 200, height: 200)
                        .cornerRadius(1000)
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 2)
                    Text(country)
                        .font(.largeTitle)
                    VStack{
                        if totalConfirmed != 0 {
                            Text("\(totalConfirmed) cases")
                                .font(.headline)
                        }
                        if totalRecovered != 0 {
                            Text("\(totalRecovered) recovered")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.511287385, blue: 0, alpha: 0.75)))
                        }
                        if totalDeaths != 0 {
                            Text("\(totalDeaths) deaths")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.75)))
                        }
                    }
                    
                }
                
                List(networkManager.detailItems){item in
                    HStack{
                        Text("\(item.province)")
                        Spacer()
                        Text("\(item.cases) Cases")
                    }
                }
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
