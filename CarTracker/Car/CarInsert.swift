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
    @State private var showTransmissionSelector = false
    @State private var showFuelTypeSelector = false
    
    var body: some View {
        ZStack{
            NavigationView {
                Form {
                    Section(header: Text("Информация об автомобиле")) {
                        
                        
                        // IMPORTANT: use right combination of placeHolder and prompt to show right
                        
                        
                        EntryField(sfSymbolName: "hurricane",
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
                        
                        EntryWheel(sfSymbolName: "calendar",
                                   placeHolder: "Год выпуска",
                                   prompt: "",
                                   dictionary: newCar.GetYearDict(),
                                   field: $newCar.selectedYearIndex,
                                   selector: $showYearSelector)
                        
                        EntryWheel(sfSymbolName: "gearshape.2",
                                   placeHolder: "Коробка передач",
                                   prompt: newCar.promptTransmissionType,
                                   dictionary: newCar.transmissionDict,
                                   field: $newCar.selectedTransmissionIndex,
                                   selector: $showTransmissionSelector)
                        
                    }
                    
                    Section(header: Text("Регистрация")) {
                        EntryWheel(sfSymbolName: "map",
                                   placeHolder: "Страна",
                                   prompt: newCar.promptCountry,
                                   dictionary: newCar.countryDict,
                                   field: $newCar.selectedCountryIndex,
                                   selector: $showCountrySelector)
                        EntryField(sfSymbolName: "number",
                                   placeHolder: "Гос. номер",
                                   prompt: newCar.promptNumberReg,
                                   field: $newCar.numberReg)
                    }
                    Section(header: Text("Топливо")) {
                        
                        EntryWheel(sfSymbolName: "flame",
                                   placeHolder: "Тип",
                                   prompt: newCar.promptFuelType,
                                   dictionary: newCar.fuelTypeDict,
                                   field: $newCar.selectedFuelTypeIndex,
                                   selector: $showFuelTypeSelector)
                        if newCar.selectedFuelTypeIndex == 4{ //
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
            WheelKeyboard(//pickerValue: $newCar.year,
                pickerValue: $newCar.selectedYearIndex,
                showSelector: $showYearSelector,
                placeholder: "Год выпуска",
                //                      internalType: "year",
                dictionary: newCar.GetYearDict()
                //                      dictionary: [""]
            )
                .opacity(showYearSelector ? 1 : 0)
                .animation(.easeIn)
            
            WheelKeyboard(pickerValue: $newCar.selectedCountryIndex,
                          showSelector: $showCountrySelector,
                          placeholder: "Страна",
                          //                      internalType: "country",
                          dictionary: newCar.countryDict)
                .opacity(showCountrySelector ? 1 : 0)
                .animation(.easeIn)
            
            WheelKeyboard(pickerValue: $newCar.selectedFuelTypeIndex,
                          showSelector: $showFuelTypeSelector,
                          placeholder: "Двигатель",
                          //                          internalType: "fuel",
                          dictionary: newCar.fuelTypeDict)
                .opacity(showFuelTypeSelector ? 1 : 0)
                .animation(.easeIn)
            WheelKeyboard(pickerValue: $newCar.selectedTransmissionIndex,
                          showSelector: $showTransmissionSelector,
                          placeholder: "Коробка передач",
                          //                          internalType: "transmission",
                          dictionary: newCar.transmissionDict)
                .opacity(showTransmissionSelector ? 1 : 0)
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
