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
    
    //    func recherche() -> Bool {
    //
    //        let request = NSFetchRequest(entityName: Car)
    //        let count  = try context.count(for: request)
    //    }
    //
    var body: some View {
        NavigationView{
            Section{
                //
                if self.cars.isEmpty{
                    Form{
                        Text("There are no objects in the current database.")
                        //                    }
                        
                    }
                }
                else{
                    List {
                        ForEach(cars, id: \.id) { car in
                            NavigationLink(destination: CarUpdate(car: car),
                                           isActive : self.$isActive
                            )
                            {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(car.make)")
                                            .font(.headline)
                                        //IOS 15 BETA
                                        //Text(income.date.formatted(.dateTime.year().month().day()))
                                        //                                Text("\(income.date, formatter: Self.stackDateFormat)")
                                        //                                    .font(.subheadline)
                                    }
                                    Spacer()
                                    //                            28Text("\(income.value, specifier: "%.2f") RUB")
                                    //                            Text("\(income.value, formatter: NumberFormatter())")
                                        .font(.headline)
                                }
                                .frame(height: 50)
                                .onTapGesture {
                                    //                            self.selectId = income.id!
                                    print("tap gesture on", car.make)
                                    //                            self.isActive.toggle()
                                    
                                }
                            }
                        }.onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(cars[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
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
        Analytics()
    }
}
