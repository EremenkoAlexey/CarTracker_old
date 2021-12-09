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
        
    @State private var showYearSelector = false
    @State private var showCountrySelector = false
    @State private var showTransmissionSelector = false
    @State private var showFuelTypeSelector = false
    @State private var showManufacturerSelector = false
    @State private var showModelSelector = false
    
    var body: some View {
        ZStack{
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        
                        ZStack { // a transparent rectangle under everything
                            Rectangle()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .opacity(0.001)   // <--- important
                                .layoutPriority(-1)
                                .onTapGesture {
                                    self.showYearSelector = false
                                    self.showCountrySelector = false
                                    self.showTransmissionSelector = false
                                    self.showFuelTypeSelector = false
                                    self.showManufacturerSelector = false
                                    self.showModelSelector = false}
                            
                            VStack{
                                Group{
                                    EntryWheel(sfSymbolName: "tag",
                                               placeHolder: "Марка",
                                               selector: $showManufacturerSelector,
                                               isValid: newCar.isManufacturer(),
                                               currentValue: newCar.simpleManufacturerDict[newCar.selectedManufacturerIndex])
                                    EntryWheel(sfSymbolName: "car",
                                               placeHolder: "Модель",
                                               selector: $showModelSelector,
                                               isValid: newCar.isModel(),
                                               currentValue: newCar.simpleModelDict[newCar.selectedModelIndex])
                                } 
                                
                                
                                EntryWheel(sfSymbolName: "calendar",
                                           placeHolder: "Год выпуска",
                                           selector: $showYearSelector,
                                           isValid: newCar.isYear(),
                                           currentValue: newCar.yearDict[newCar.selectedYearIndex])
                                
                                EntryField(sfSymbolName: "hurricane",
                                           placeHolder: "Мощность, л.с.",
                                           prompt: newCar.promptHorsePower,
                                           keyboard: "number",
                                           field: $newCar.horsePower,
                                           isValid: newCar.isHorsePower())
                                
                                EntryField(sfSymbolName: "speedometer",
                                           placeHolder: "Текущий пробег, км.",
                                           prompt: newCar.promptMileage,
                                           keyboard: "number",
                                           field: $newCar.mileage,
                                           isValid: newCar.isMileage())
                                
                                
                                EntryField(sfSymbolName: "v.square",
                                           placeHolder: "VIN(необязательно)",
                                           prompt: " ",
                                           field: $newCar.numberVIN,
                                           isValid: true)
                                
                                
                                
                                EntryWheel(sfSymbolName: "gearshape.2",
                                           placeHolder: "Коробка передач",
                                           selector: $showTransmissionSelector,
                                           isValid: newCar.isTransmissionType(),
                                           currentValue: newCar.transmissionDict[newCar.selectedTransmissionIndex])
                                
                                
                                EntryWheel(sfSymbolName: "map",
                                           placeHolder: "Страна",
                                           selector: $showCountrySelector,
                                           isValid: newCar.isCountry(),
                                           currentValue: newCar.countryDict[newCar.selectedCountryIndex])
                                EntryField(sfSymbolName: "number",
                                           placeHolder: "Гос. номер",
                                           prompt: newCar.promptNumberReg,
                                           field: $newCar.numberReg,
                                           isValid: newCar.isNumberRegValid())
                                Group{
                                    
                                    
                                    EntryWheel(sfSymbolName: "flame",
                                               placeHolder: "Тип топлива",
                                               selector: $showFuelTypeSelector,
                                               isValid: newCar.isFuelType(),
                                               currentValue: newCar.fuelTypeDict[newCar.selectedFuelTypeIndex])
                                    
                                    if newCar.selectedFuelTypeIndex == 4{ // electricity
                                        EntryField(sfSymbolName: "bolt.batteryblock",
                                                   placeHolder: "Объем батареи, кВт.ч",
                                                   prompt: newCar.promptFuelVolume,
                                                   keyboard: "number",
                                                   field: $newCar.fuelVolume,
                                                   isValid: newCar.isFuelVolume())
                                        
                                    }
                                    else{
                                        EntryField(sfSymbolName: "fuelpump",
                                                   placeHolder: "Объем бака, л.",
                                                   prompt: newCar.promptFuelVolume,
                                                   keyboard: "number",
                                                   field: $newCar.fuelVolume,
                                                   isValid: newCar.isFuelVolume())
                                    }
                                }//group
                                Button(action: {
                                    newCar.SaveCar(viewContext)
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    WhiteBoldButtonText(textValue: "Добавить")
                                }
                                .buttonStyle(RoundYellowToGreenButton(isValid: newCar.isReadyInsert))
                            }.padding(18)//vstack
                        }
                    }
                }
                .navigationTitle("Добавление авто")
            }
            
            WheelKeyboard(pickerValue: $newCar.selectedYearIndex,
                          showSelector: $showYearSelector,
                          placeholder: "Год выпуска",
                          dictionary: newCar.yearDict)
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
            WheelKeyboard(pickerValue: $newCar.selectedManufacturerIndex,
                          showSelector: $showManufacturerSelector,
                          placeholder: "Марка",
                          dictionary: newCar.simpleManufacturerDict)
                .opacity(showManufacturerSelector ? 1 : 0)
                .animation(.easeIn)
            WheelKeyboard(pickerValue: $newCar.selectedModelIndex,
                          showSelector: $showModelSelector,
                          placeholder: "Модель",
                          dictionary: newCar.simpleModelDict)
                .opacity(showModelSelector ? 1 : 0)
                .animation(.easeIn)
        }
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
