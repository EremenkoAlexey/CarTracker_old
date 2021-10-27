//
//  CarModel.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 11.10.2021.
//

import Foundation
import CoreData
import SwiftUI

let defaultValue = "Выбрать"

//class ContentViewModel: ObservableObject {
//    let carData: [Manufacturer]
//
//    @Published var selectedManufacturer = -1 {
//        didSet {
//            // reset the currently selected model to "None" when the manufacturer changes
//            selectedModel = -1
//        }
//    }
//    @Published var selectedModel = -1
//    var models: [Model] {
//        if (0 ..< carData.count).contains(selectedManufacturer) {
//            return carData[selectedManufacturer].models
//        }
//
//        return []
//    }


//}

class CarModel : ObservableObject{
    
    init() {
        let url = Bundle.main.url(forResource: "Cars", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        makeDict = try! JSONDecoder().decode([Manufacturer].self, from: data)
    }
   // let makeDict = ["Renault", "BMW", "Volkswagen", "Audi", "Other"]
    let makeDict: [Manufacturer]
//    let modelDict = ["Sandero", "i3", "Touareg", "A5", "Other"]
    var modelDict: [Model] {
        if (0 ..< makeDict.count).contains(selectedMakeIndex) {
            return makeDict[selectedMakeIndex].models
        }

        return []
    }
    @Published var selectedMakeIndex = -1{
    didSet {
        // reset the currently selected model to "None" when the manufacturer changes
        selectedModelIndex = -1
    }
    }
    @Published var selectedModelIndex = -1
    
    let countryDict = [defaultValue, "Россия", "Беларусь", "Украина", "Другая"]
    @Published var selectedCountryIndex = 0
    
    let transmissionDict = [defaultValue, "АКПП", "МКПП", "Робот", "Вариатор"]
    @Published var selectedTransmissionIndex = 0

    var yearDict : [String] = [defaultValue]
    @Published var selectedYearIndex = 0
    @Published var year : Int = Calendar.current.dateComponents([.year], from: Date()).year!
    
    let fuelTypeDict = [defaultValue, "Бензин", "Дизель", "Гибрид", "Электро", "Газ", "Пропан", "Метан"]
    @Published var selectedFuelTypeIndex = 0

    @Published var fuelVolume : Float = 0.0
    @Published var horsePower = ""
    @Published var mileage = ""
    @Published var numberVIN = ""
    @Published var numberReg = ""
    @Published var remarks = ""
    
    func GetYearDict()->[String]{
        var tempYearDict = ((year-100)...year).reversed().map { String($0) }
        tempYearDict.insert(defaultValue, at: 0)
        return tempYearDict
    }
    
    func SaveCar(_ context: NSManagedObjectContext){
        //        guard self.incomeValue != "" else {return}
        let newCar = Car(context: context)
        
//        newCar.make = self.makeDict[self.selectedMakeIndex]
//        newCar.model = self.modelDict[self.selectedModelIndex]
//        newCar.year = self.yearDict[self.selectedYearIndex]
        newCar.year = String(self.year)
//        newCar.country = self.countryDict[self.selectedCountryIndex]
//        newCar.country = self.country
        newCar.id = UUID()
        newCar.remark = self.remarks
        newCar.dateAdded = Date()
        newCar.dateUpdate = Date()
        newCar.horsePower = Float(self.horsePower) ?? 0
        newCar.numberReg = self.numberReg
        newCar.numberVIN = self.numberVIN
//        newCar.district = self.countryDict[self.selectedDistrictIndex]
        
        //        newCar.transmissionType = self.transmissionDict[self.selectedTransmissionIndex]
        
//        newCar.transmissionType = self.transmissionChoice!
//        newCar.fuelType = self.fuelTypeChoice!
        //        newCar.transmissionType = self.transmissionChoice
        //        newCar.fuelType = self.fuelTypeChoice
        
        newCar.fuelVolume = self.fuelVolume
        newCar.mileage = Float(self.mileage) ?? 0
        
        newCar.isArchive = false
        
        //        newCar.color = self.color
        //        newCar.picture = self.picture
        
        do {
            try context.save()
            print("Car saved.")
            //            presentationMode.wrappedValue.dismiss()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    var promptFuelType: String {
        if isFuelType() {
            return ""
        } else {
            return "Выберите тип топлива для двигателя"
        }
    }
    
    func isFuelType() -> Bool {
        if selectedFuelTypeIndex != 0 {
//        if fuelType != nil && fuelType != defaultValue{
            return true
        }
        else{
            return false
        }
    }

    var promptTransmissionType: String {
        if isTransmissionType() {
            return ""
        } else {
            return "Выберите тип коробки передач"
        }
    }
    
    func isTransmissionType() -> Bool {
        if selectedTransmissionIndex != 0 {
            return true
        }
        else{
            return false
        }
    }

    var promptCountry: String {
        if isCountry() {
            return ""
        } else {
            return "Выберите страну регистрации"
        }
    }
    
    func isCountry() -> Bool {
        if selectedCountryIndex != 0 {
            return true
        }
        else{
            return false
        }
    }
    
    var promptFuelVolume: String {
        if isFuelVolume() {
            return ""
        } else {
            return "Введите объем"
        }
    }
    
    func isFuelVolume() -> Bool {
        if fuelVolume != 0.0 {
            return true
        }
        else{
            return false
        }
    }
    
    var promptMileage: String {
        if isMileage() {
            return ""
        } else {
            return "Введите текущее показание одометра"
        }
    }
    
    func isMileage() -> Bool {
        if mileage != ""{
            return true
        }
        else{
            return false
        }
    }

    var promptHorsePower: String {
        if isHorsePower() {
            return ""
        } else {
            return "Введите мощность двигателя"
        }
    }
    
    func isHorsePower() -> Bool {
        if horsePower != ""{
            return true
        }
        else{
            return false
        }
    }
    
    var promptOptional: String {
        return "Необязательное поле"
    }
    
    func isNumberRegValid() -> Bool {
        let testDefault = NSPredicate(format: "SELF MATCHES %@",
                                      "[a-z0-9]{1,15}")
        
        let testRussia = NSPredicate(format: "SELF MATCHES %@",
                                     "^[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0423\\u0425]{1}[0-9]{3}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0423\\u0425]{2}\\u0020([0-9]{2}|[1-9]{1}[0-9]{2})$")

        let testUkraine = NSPredicate(format: "SELF MATCHES %@",
                                     "^[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}\\u0020[0-9]{4}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}$")
        
        let testBelarus = NSPredicate(format: "SELF MATCHES %@",
                                     "^[0-9]{4}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}\\u0020[0-8]{1}$")

        switch selectedCountryIndex{
        case 1: // Russia
            return testRussia.evaluate(with: numberReg)
        case 2: // Belarus
            return testBelarus.evaluate(with: numberReg)
        case 3: // Ukraine
            return testUkraine.evaluate(with: numberReg)
        default:
            return testDefault.evaluate(with: numberReg)
        }
    }
    
    var promptNumberReg: String {
        if isNumberRegValid() {
            return ""
        } else {
            switch selectedCountryIndex{
            case 1: // Russia
                return "Введите номер в формате А123АА 77"
            case 2: // Belarus
                return "Введите номер в формате 1234АА 7"
            case 3: // Ukraine
                return "Введите номер в формате AA 1234AA"
            default:
                return "Неверный формат номера"
            }        }
    }
    
    var isReadyInsert: Bool {
        if !isMileage() ||
            !isFuelType() ||
            !isFuelVolume() ||
            !isTransmissionType() ||
            !isHorsePower() ||
            !isNumberRegValid(){
            return false
        }
        return true
    }
}
