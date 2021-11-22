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
        manufacturerDict = try! JSONDecoder().decode([Manufacturer].self, from: data)
    }
    let manufacturerDict: [Manufacturer]
    var modelDict: [Model] {
        if (0 ..< manufacturerDict.count).contains(selectedManufacturerIndex) {
            return manufacturerDict[selectedManufacturerIndex].models
        }

        return []
    }
    @Published var selectedManufacturerIndex = -1{
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

    @Published var fuelVolume : Float = 0
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

        newCar.id = UUID()
        newCar.dateAdded = Date()
        newCar.dateUpdate = Date()
        newCar.isArchive = false
        


        newCar.manufacturer = self.manufacturerDict[self.selectedManufacturerIndex].brand
        newCar.model = self.modelDict[self.selectedModelIndex].name
        newCar.horsePower = Float(self.horsePower) ?? 0
        newCar.mileage = Float(self.mileage) ?? 0
        newCar.numberVIN = self.numberVIN
        newCar.year = String(self.year)


        
        newCar.country = self.countryDict[self.selectedCountryIndex]
        newCar.numberReg = self.numberReg
        
        newCar.fuelType = self.fuelTypeDict[self.selectedFuelTypeIndex]
        newCar.fuelVolume = self.fuelVolume
        
        do {
            try context.save()
            print("Car saved.")
            //            presentationMode.wrappedValue.dismiss()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    enum WeatherType {
//        case sun
//        case cloud
//        case rain
//        case wind(speed: Int)
//        case snow
//    }
//
//    func getHaterStatus(weather: WeatherType) -> String? {
//        switch isFuelType() {
//        case .sun:
//            return nil
//        case .wind(let speed) where speed < 10:
//            return "meh"
//        case .cloud, .wind:
//            return "dislike"
//        case .rain, .snow:
//            return "hate"
//        }
//    }
//
    let testWholeNumber = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{3}$")
    let testFractionalNumber = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{1,3}[\\u002C][0-9]{1}$")

    let promptHorsePower: String = "Введите мощность двигателя"
    let promptFuelType: String = "Выберите тип топлива для двигателя"
    let promptTransmissionType: String = "Выберите тип коробки передач"
    let promptCountry: String = "Выберите страну регистрации"
    let promptFuelVolume: String = "Введите текущее показание одометра"
    let promptOptional: String = "Необязательное поле"
//    let promptMileage: String = "Введите текущее показание одометра"
    var promptNumberReg: String {
        switch selectedCountryIndex{
            case 1: // Russia
                return "Введите номер в формате А123АА 77"
            case 2: // Belarus
                return "Введите номер в формате 1234АА 7"
            case 3: // Ukraine
                return "Введите номер в формате AA 1234AA"
            default:
                return "Неверный формат номера"
            }
    }
    
//    var promptHorsePower: String {
//        if isHorsePower() {
//            return ""
//        } else {
//            return "Введите мощность двигателя"
//        }
//    }
//
//    var promptFuelType: String {
//        if isFuelType() {
//            return ""
//        } else {
//            return "Выберите тип топлива для двигателя"
//        }
//    }
//
//    var promptTransmissionType: String {
//        if isTransmissionType() {
//            return ""
//        } else {
//            return "Выберите тип коробки передач"
//        }
//    }
//
//    var promptCountry: String {
//        if isCountry() {
//            return ""
//        } else {
//            return "Выберите страну регистрации"
//        }
//    }
//
//    var promptFuelVolume: String {
//        if isFuelVolume() {
//            return ""
//        } else {
//            return "Введите объем"
//        }
//    }
//

//
//    var promptOptional: String {
//        return "Необязательное поле"
//    }
//
//    var promptNumberReg: String {
//        if isNumberRegValid() {
//            return ""
//        } else {
//            switch selectedCountryIndex{
//            case 1: // Russia
//                return "Введите номер в формате А123АА 77"
//            case 2: // Belarus
//                return "Введите номер в формате 1234АА 7"
//            case 3: // Ukraine
//                return "Введите номер в формате AA 1234AA"
//            default:
//                return "Неверный формат номера"
//            }        }
//    }
    
    func isFuelType() -> Bool {
        if selectedFuelTypeIndex != 0 {
            return true
        }
        else{
            return false
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
    
    func isCountry() -> Bool {
        if selectedCountryIndex != 0 {
            return true
        }
        else{
            return false
        }
    }
    
    func isYear() -> Bool {
        if selectedYearIndex != 0 {
            return true
        }
        else{
            return false
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
    
    func isMileage() -> Bool {
        if (mileage != "")&&(testWholeNumber.evaluate(with: mileage)||testFractionalNumber.evaluate(with: mileage)){
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
    
    func isHorsePower() -> Bool {
        if horsePower != ""{
            return true
        }
        else{
            return false
        }
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
