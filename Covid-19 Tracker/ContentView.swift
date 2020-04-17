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
    var dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                //                MapView()
                //                    .edgesIgnoringSafeArea(.top)
                //                    .frame(height: 100 )
                VStack {
                    VStack {
                        
                        //                        circleChart()
                        HStack {
                            Spacer()
                            globalSubview(value: networkManager.global.totalConfirmed, alertColor: Color(#colorLiteral(red: 0, green: 0.6401130557, blue: 0.8553348184, alpha: 1)), label: "Total Cases")
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            globalSubview(value: networkManager.global.totalRecovered, alertColor: Color(#colorLiteral(red: 0, green: 0.4885927914, blue: 0, alpha: 1)), label: "Recovered")
                            Spacer()
                            globalSubview(value: networkManager.global.totalDeaths, alertColor: Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), label: "Deaths")
                            Spacer()
                        }
                        Divider()
                    }
                    List(networkManager.items){ item in
                        NavigationLink(
                            destination: DetailView(
                                country: "\(item.country)",
                                slug: "\(item.slug)",
                                newConfirmed: item.newConfirmed,
                                totalConfirmed: item.totalConfirmed,
                                newDeaths: item.newDeaths,
                                totalDeaths: item.totalDeaths,
                                newRecovered: item.newRecovered,
                                totalRecovered: item.totalRecovered)) {
                                    VStack {
                                        HStack {
                                            Text("\(item.country)")
                                                .fontWeight(.medium)
                                                .padding(.bottom)
                                                .opacity(0.90)
                                            Spacer()
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Text("\(item.totalConfirmed) cases")
                                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6401130557, blue: 0.8553348184, alpha: 1)))
                                                }
                                                //                                                Divider()
                                            }
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            Text("\(item.totalDeaths) deaths")
                                                .font(.footnote)
                                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
                                            Text("\(item.totalRecovered) recovered")
                                                .font(.footnote)
                                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.4885927914, blue: 0, alpha: 1)))
                                        }
                                    }
                        }
                    }
                }
                
            }
                
            .navigationBarTitle("Worldwide", displayMode: .automatic)
            
        }
        .onAppear(){
            self.networkManager.getGlobal()
            self.networkManager.getWorldSummary()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct globalTitleView: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 25))
                .fontWeight(.medium)
            Text("\(label)")
                .font(.footnote)
        }
    }
}

struct globalSubview: View {
    let value: Int
    let alertColor: Color
    let label: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(alertColor)
            Text("\(label)")
                .font(.footnote)
                .foregroundColor(alertColor)
        }
    }
}

//struct circleChart: View {
//
//    @ObservedObject var networkManager = NetworkManager()
//
//    greyBar: Double = Double(networ)
//    var redBar: Double
//    var greenBar: Double
//
//    var configuration = SunburstConfiguration(nodes: [
//        Node(name: "Total", showName: true, value: greyBar, backgroundColor: #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)),
//        Node(name: "Recovered", showName: true, value: greenBar, backgroundColor: #colorLiteral(red: 0, green: 0.4885927914, blue: 0, alpha: 1)),
//        Node(name: "Deaths", showName: true, value: redBar, backgroundColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)),
//    ])
//
//    var body: some View {
//        SunburstView(configuration: configuration)
//    }
//}
