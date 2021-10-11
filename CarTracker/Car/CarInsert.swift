//
//  CarInsert.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI

struct CarInsert: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode

    @Binding var showView : Bool
    
//    @State var selectedMakeIndex = 0
//    @State var selectedModelIndex = 0
//    @State var selectedYearIndex = 0
//    @State var selectedCountryIndex = 0
//    @State var selectedDistrictIndex = 0
//    @State var selectedFuelTypeIndex = 0
//    @State var selectedTransmissionIndex = 0
//
//    @State var fuelVolume = ""
//
//    @State var horsePower = ""
//    @State var mileage = ""
//    @State var numberVIN = ""
//    @State var numberReg = ""
//    //@State var color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
//
//    @State var remarks = ""

    @ObservedObject var newCar = CarModel()
    
//    init(viewContext: NSManagedObjectContext) {
//            self.CarModel = CarModel(context: context)   // initialize
//        }
    
    struct SelectionCell: View {

        let fruit: String
        @Binding var selectedFruit: String?

        var body: some View {
            HStack {
                Text(fruit)
                Spacer()
                if fruit == selectedFruit {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }.contentShape(Rectangle())
            .onTapGesture {
                self.selectedFruit = self.fruit
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Информация об автомобиле")) {
                    Picker(selection: $newCar.selectedMakeIndex, label: Text("Производитель")) {
                        ForEach(0 ..< newCar.makeDict.count) {
                            Text(newCar.makeDict[$0]).tag($0)
                        }
                    }
                    Picker(selection: $newCar.selectedModelIndex, label: Text("Марка")) {
                        ForEach(0 ..< newCar.modelDict.count) {
                            Text(newCar.modelDict[$0]).tag($0)
                        }
                    }
//                    Picker(selection: $newCar.selectedFuelTypeIndex, label: Text("Двигатель")) {
//                        ForEach(0 ..< newCar.fuelTypeDict.count) {
//                            Text(newCar.fuelTypeDict[$0]).tag($0)
//                        }
//                    }

//                    Picker(selection: $newCar.selectedTransmissionIndex, label: Text("Коробка передач")) {
//                        ForEach(0 ..< newCar.transmissionDict.count) {
//                            Text(newCar.transmissionDict[$0]).tag($0)
//                        }
//                    }
                    
                    EntryField(sfSymbolName: "fuelpump.circle.fill",
                               placeHolder: "Объем бака, л./кВт.ч",
                               prompt: "",
                               field: $newCar.fuelVolume)
                        .keyboardType(.decimalPad)
                    
//                    Picker(selection: $newCar.selectedYearIndex, label: Text("Год выпуска")) {
////                        ForEach((1950...2021).reversed(), id: \.self){Text(String($0))
//                        ForEach(0 ..< newCar.yearDict.count) {
//                            Text(newCar.yearDict[$0]).tag($0)
//                        }
//                    }
                    EntryField(sfSymbolName: "gearshape.2",
                               placeHolder: "Мощность, л.с.",
                               prompt: "",
                               field: $newCar.horsePower)
                        .keyboardType(.decimalPad)
                    
                    EntryField(sfSymbolName: "speedometer",
                               placeHolder: "Текущий пробег, км.",
                               prompt: "",
                               field: $newCar.mileage)
                        .keyboardType(.decimalPad)
                    
                    EntryField(sfSymbolName: "v.square",
                               placeHolder: "VIN",
                               prompt: "",
                               field: $newCar.numberVIN)
                }
                Section(header: Text("Двигатель")) {
                    List(newCar.fuelTypeDict, id: \.self) {item in
                        SelectionCell(fruit: item, selectedFruit: $newCar.fuelTypeChoice)
                    }
                }
                
                Section(header: Text("Коробка передач")) {
                    List(newCar.transmissionDict, id: \.self) {item in
                        SelectionCell(fruit: item, selectedFruit: $newCar.transmissionChoice)
                    }
                }
                Picker(selection: $newCar.selectedYearIndex, label: Text("Год выпуска")) {
//                        ForEach((1950...2021).reversed(), id: \.self){Text(String($0))
                    ForEach(0 ..< newCar.yearDict.count) {
                        Text(newCar.yearDict[$0]).tag($0)
                    }
                }

                    Section(header: Text("Регистрация")) {

                        Picker(selection: $newCar.selectedCountryIndex, label: Text("Страна")) {
                            ForEach(0 ..< newCar.countryDict.count) {
                                Text(newCar.countryDict[$0]).tag($0)
                        }
                    }
                        Picker(selection: $newCar.selectedDistrictIndex, label: Text("Регион")) {
                            ForEach(0 ..< newCar.districtDict.count) {
                                Text(newCar.districtDict[$0]).tag($0)
                        }
                    }
                    EntryField(sfSymbolName: "number",
                               placeHolder: "Гос. номер",
                               prompt: "",
                               field: $newCar.numberReg)
                    //ColorPicker("Choose color", selection: $color)
                }
                
                Button(action: {
                    newCar.SaveCar(viewContext)
//                    if newCar.SaveCar(){
                        presentationMode.wrappedValue.dismiss()
//                    }
//                    else{
//                        print("show alert")
//                    }
                })
                {
                    Text("Добавить")
                }
            }
                .navigationTitle("Добавление авто")
        }.toolbar {
            EditButton()
        }
    }
}

struct CarInsert_Previews2: View{
    @State private var showingDetail = true
    
    var body: some View {
        CarInsert(showView: $showingDetail)
    }
}
struct CarInsert_Previews: PreviewProvider {
    static var previews: some View {
        CarInsert_Previews2()
    }
}
