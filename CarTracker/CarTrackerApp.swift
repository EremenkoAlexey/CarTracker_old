//
//  CarTrackerApp.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI

@main
struct CarTrackerApp: App {
    @Environment(\.scenePhase) var scenePhase

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Main()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }.onChange(of: scenePhase) { _ in
            //print("saving pers controller")
            persistenceController.save()
        }
    }
    
    struct CarTrackerApp_Previews: PreviewProvider {
        static var previews: some View {
            Main()
        }
    }
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
}
