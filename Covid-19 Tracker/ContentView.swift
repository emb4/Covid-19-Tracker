//
//  ContentView.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 3/31/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
                MapView()
                    .edgesIgnoringSafeArea(.top)
                .frame(height: 100 )
                VStack {
                    HStack {
                        Text("World cases by country")
                            .padding(.horizontal)
                            .font(.headline)
                        Spacer()
                        //                    Text("Cases")
                        //                        .padding(.horizontal)
                    }
                    List(networkManager.items){ item in
                        NavigationLink(
                            destination: DetailView(
                            country: "\(item.Country)",
                            slug: "\(item.Slug)",
                            newConfirmed: item.NewConfirmed,
                            totalConfirmed: item.TotalConfirmed,
                            newDeaths: item.NewDeaths,
                            totalDeaths: item.TotalDeaths,
                            newRecovered: item.NewRecovered,
                            totalRecovered: item.TotalRecovered)) {
                                VStack {
                                    HStack {
                                        Text("\(item.Country)")
                                            .fontWeight(.medium)
                                        Spacer()
                                        Text("\(item.TotalConfirmed) cases")
                                    }
                                    HStack {
                                        Spacer()
                                        Text("+\(item.NewConfirmed) new")
                                            .font(.footnote)
                                    }
                                    HStack {
                                        Spacer()
                                        Text("\(item.TotalDeaths) deaths")
                                            .font(.footnote)
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
                                        Text("\(item.TotalRecovered) recovered")
                                            .font(.footnote)
                                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.4885927914, blue: 0, alpha: 1)))
                                    }
                                }
                        }
                    }
                }
                
            }
        
//            .navigationBarTitle("COVID-19 Tracker", displayMode: .inline)
            
        }
        .onAppear(){
            self.networkManager.getWorldSummary()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
