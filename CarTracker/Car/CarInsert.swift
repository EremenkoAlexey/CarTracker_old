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
    
    @ObservedObject var newCar = CarModel()

    //@State private var isEditing = false
    
    @State private var showYearSelector = false
    @State private var showCountrySelector = false

    var body: some View {
        ZStack{
        NavigationView {
            Form {
                Section(header: Text("Информация об автомобиле")) {
   

                    // IMPORTANT: use right combination of placeHolder and prompt to show right
                    if newCar.fuelTypeChoice == "Электро"{
                        EntrySlider(sfSymbolName: "fuelpump.circle.fill",
                                    placeHolder: "Объем батареи, кВт.ч",
                                    prompt: newCar.promptFuelVolume,
                                    field: $newCar.fuelVolume)

                    }
                    else{
                        EntrySlider(sfSymbolName: "fuelpump.circle.fill",
                                    placeHolder: "Объем бака, л.",
                                    prompt: newCar.promptFuelVolume,
                                    field: $newCar.fuelVolume)
                    }
                    
                    EntryField(sfSymbolName: "gearshape.2",
                               placeHolder: "Мощность, л.с.",
                               prompt: newCar.promptHorsePower,
                               keyboard: "number",
                               field: $newCar.horsePower)
                    
                    EntryField(sfSymbolName: "speedometer",
                               placeHolder: "Текущий пробег, км.",
                               prompt: newCar.promptMileage,
                               keyboard: "number",
                               field: $newCar.mileage)
                    
                    EntryField(sfSymbolName: "v.square",
                               placeHolder: "VIN",
                               prompt: newCar.promptOptional,
                               field: $newCar.numberVIN)
                    
                    EntryField(sfSymbolName: "number",
                               placeHolder: "Гос. номер",
                               prompt: newCar.promptOptional,
                               field: $newCar.numberReg)
                

                    EntryWheel(sfSymbolName: "calendar",
                               placeHolder: "Год выпуска",
                               prompt: "",
                               internalType: "year",
                               field: $newCar.year,
                               selector: $showYearSelector)
                    
                    
                    EntryWheel(sfSymbolName: "map",
                               placeHolder: "Страна",
                               prompt: "",
                               internalType: "country",
                               field: $newCar.selectedCountryIndex,
                               selector: $showCountrySelector)
                    
                }
                Section(header: Text("Двигатель"), footer: Text(newCar.promptFuelType)) {
                    List(newCar.fuelTypeDict, id: \.self) {item in
                        SelectionCell(item: item, selectedItem: $newCar.fuelTypeChoice)
                    }
                }
                Section(header: Text("Коробка передач"), footer: Text(newCar.promptTransmissionType)) {
                    List(newCar.transmissionDict, id: \.self) {item in
                        SelectionCell(item: item, selectedItem: $newCar.transmissionChoice)
                    }
                }
                


                    Section(header: Text("надо переделать")) {
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

                        Picker(selection: $newCar.selectedDistrictIndex, label: Text("Регион")) {
                            ForEach(0 ..< newCar.districtDict.count) {
                                Text(newCar.districtDict[$0]).tag($0)
                        }
                    }
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
                
                .opacity(newCar.isReadyInsert ? 1 : 0.6)
                .disabled(!newCar.isReadyInsert)
            }
                .navigationTitle("Добавление авто")
            
        }
        // Picker overlay only displayed when year field tapped
        WheelKeyboard(pickerValue: $newCar.year,
                      showSelector: $showYearSelector,
                      placeholder: "Год выпуска",
                      internalType: "year")
            .opacity(showYearSelector ? 1 : 0)
            .animation(.easeIn)
        WheelKeyboard(pickerValue: $newCar.selectedCountryIndex,
                      showSelector: $showCountrySelector,
                      placeholder: "Страна",
                      internalType: "country")
                .opacity(showCountrySelector ? 1 : 0)
                .animation(.easeIn)
            //        WheelKeyboardString(pickerValue: $newCar.country,
//                            showSelector: $showCountrySelector,
//                            placeholder: "Страна",
//                            internalType: "country")
//            .opacity(showCountrySelector ? 1 : 0)
//            .animation(.easeIn)
        }
//            .toolbar {
//            EditButton()
//            }
        
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
