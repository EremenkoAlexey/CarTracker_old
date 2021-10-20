//
//  Analytics.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI
import CoreData

struct Analytics: View {
    @State var showCarInsert :Bool = false
    
    @State private var selectId = UUID()
    
    @State var isActive = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Car.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Car.dateAdded, ascending: false)])
    
    var cars: FetchedResults<Car>
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            Section{
                if self.cars.isEmpty{
                    List {
                        ScrollView(.horizontal) {
                            HStack{
                                InsertCarCard(showSheet: $showCarInsert)
                            }.padding()
                        }
                    }
                }//.listStyle(PlainListStyle())
                else{
                    List {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(cars, id: \.id) {
                                    car in NavigationLink(destination: CarUpdate(car: car),
                                                          isActive : self.$isActive){
                                        SmallCarCard(car: car)
                                    }
                                }
                            }.padding()
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Car")
            .navigationBarItems(trailing: Button(action: {
                print("Open order sheet")
                showCarInsert = true
            }, label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showCarInsert) {
                CarInsert(showView: self.$showCarInsert)
                
            }
        }
        
    }
    
}

struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        Analytics().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
        
    }
}
