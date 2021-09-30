//
//  Main.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI

// фон для таб бара
//    init() {
//            UITabBar.appearance().barTintColor = UIColor.red
//        }
struct Main: View {
    var body: some View {
        TabView {
            Group{
                Analytics()
                    .tabItem {
                        Image(systemName: "chart.pie.fill")
                        Text("Analytics")
                    }
                CarList()
                    .tabItem {
                        Image(systemName: "text.badge.plus")
                        Text("Income")
                    }
                Account()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
                Settings()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.foregroundColor(Color("DarkGreen"))
            }
            //.onAppear(perform: getUser)
        }.accentColor(Color("DarkGreen"))
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
