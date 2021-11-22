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
    //    @EnvironmentObject var showYearSelector = false
    
    @State private var showYearSelector = false
    @State private var showCountrySelector = false
    @State private var showTransmissionSelector = false
    @State private var showFuelTypeSelector = false
    
    var body: some View {
        ZStack{
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        // a transparent rectangle under everything
                        Rectangle()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .opacity(0.001)   // <--- important
                            .layoutPriority(-1)
                            .onTapGesture {
                                self.showYearSelector = false
                                self.showCountrySelector = false
                                self.showTransmissionSelector = false
                                self.showFuelTypeSelector = false
                                
                            }
                        //                Form {
                        //
                        //
                                                VStack{
                        //                    Section(header: Text("Информация об автомобиле")) {
                        //
                                                CarModels(manufacturerPickerValue: $newCar.selectedManufacturerIndex,
                                                          manufacturerDictionary: newCar.manufacturerDict,
                                                          modelPickerValue: $newCar.selectedModelIndex,
                                                          modelDictionary: newCar.modelDict)
                        
                        RoundEntryField(sfSymbolName: "hurricane",
                                        placeHolder: "Мощность, л.с.",
                                        prompt: "",
                                        keyboard: "number",
                                        field: $newCar.horsePower,
                                        isValid: newCar.isHorsePower())
                        
                        RoundEntryField(sfSymbolName: "speedometer",
                                        placeHolder: "Текущий пробег, км.",
                                        prompt: newCar.promptMileage,
                                        keyboard: "number",
                                        field: $newCar.mileage,
                                        isValid: newCar.isMileage())
                        
                        RoundEntryField(sfSymbolName: "v.square",
                                        placeHolder: "VIN",
                                        prompt: "",
                                        field: $newCar.numberVIN,
                                        isValid: true)
                        
                        RoundEntryWheel(sfSymbolName: "calendar",
                                        placeHolder: "Год выпуска",
                                        prompt: "",
                                        dictionary: newCar.GetYearDict(),
                                        field: $newCar.selectedYearIndex,
                                        selector: $showYearSelector,
                                        isValid: newCar.isYear())
                        
                        RoundEntryWheel(sfSymbolName: "gearshape.2",
                                        placeHolder: "Коробка передач",
                                        prompt: "",
                                        dictionary: newCar.transmissionDict,
                                        field: $newCar.selectedTransmissionIndex,
                                        selector: $showTransmissionSelector,
                                        isValid: newCar.isTransmissionType())

                                                    
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
                                                        EntrySlider(sfSymbolName: "bolt.batteryblock",
                                                                    placeHolder: "Объем батареи, кВт.ч",
                                                                    prompt: newCar.promptFuelVolume,
                                                                    field: $newCar.fuelVolume)
                            
                                                    }
                                                    else{
                                                        EntrySlider(sfSymbolName: "fuelpump",
                                                                    placeHolder: "Объем бака, л.",
                                                                    prompt: newCar.promptFuelVolume,
                                                                    field: $newCar.fuelVolume)
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
                        //                    .buttonStyle(GreenButtonStyle())
                        
                        .opacity(newCar.isReadyInsert ? 1 : 0.6)
                        .disabled(!newCar.isReadyInsert)
                        
                        //                }//form
                                                }.padding(18)//vstack
                    }
                }
                .navigationTitle("Добавление авто")
            }
            
            WheelKeyboard(pickerValue: $newCar.selectedYearIndex,
                          showSelector: $showYearSelector,
                          placeholder: "Год выпуска",
                          dictionary: newCar.GetYearDict())
                .opacity(showYearSelector ? 1 : 0)
                .animation(.easeIn)
            
            WheelKeyboard(pickerValue: $newCar.selectedCountryIndex,
                          showSelector: $showCountrySelector,
                          placeholder: "Страна",
                          dictionary: newCar.countryDict)
                .opacity(showCountrySelector ? 1 : 0)
                .animation(.easeIn)
            
            WheelKeyboard(pickerValue: $newCar.selectedFuelTypeIndex,
                          showSelector: $showFuelTypeSelector,
                          placeholder: "Двигатель",
                          dictionary: newCar.fuelTypeDict)
                .opacity(showFuelTypeSelector ? 1 : 0)
                .animation(.easeIn)
            WheelKeyboard(pickerValue: $newCar.selectedTransmissionIndex,
                          showSelector: $showTransmissionSelector,
                          placeholder: "Коробка передач",
                          dictionary: newCar.transmissionDict)
                .opacity(showTransmissionSelector ? 1 : 0)
                .animation(.easeIn)
            
        }
        //            .toolbar {
        //            EditButton()
        //            }
        .onAppear(perform:UIApplication.shared.addTapGestureRecognizer)
    }
}
extension UIApplication {
    func addTapGestureRecognizer(){
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
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
