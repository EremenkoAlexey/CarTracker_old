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

class CarModel : ObservableObject{
    
    init() {
        let url = Bundle.main.url(forResource: "Cars", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        manufacturerDict = try! JSONDecoder().decode([Manufacturer].self, from: data)
    }
    let manufacturerDict: [Manufacturer]
    var modelDict: [Model] {
        // added "-1" as added defaultValue at start and we need this shift
        if (0 ..< manufacturerDict.count).contains(selectedManufacturerIndex-1) {
            return manufacturerDict[selectedManufacturerIndex-1].models
        }

        return []
    }
    
    // added "-1" as added defaultValue at start and we need this shift
    @Published var selectedModelIndex = 0 //-1
    @Published var selectedManufacturerIndex = 0{//-1
    didSet {
        // reset the currently selected model to "None" when the manufacturer changes
        selectedModelIndex = 0 //-1
        }
    }
    
    let countryDict = [defaultValue, "Россия", "Беларусь", "Украина", "Другая"]
    @Published var selectedCountryIndex = 0
    
    let transmissionDict = [defaultValue, "АКПП", "МКПП", "Робот", "Вариатор"]
    @Published var selectedTransmissionIndex = 0

//    var yearDict : [String] = [defaultValue]
    @Published var selectedYearIndex = 0
    @Published var year : Int = Calendar.current.dateComponents([.year], from: Date()).year!
    
    let fuelTypeDict = [defaultValue, "Бензин", "Дизель", "Гибрид", "Электро", "Газ", "Пропан", "Метан"]
    @Published var selectedFuelTypeIndex = 0

    @Published var fuelVolume = ""
    @Published var horsePower = ""
    @Published var mileage = ""
    @Published var numberVIN = ""
    @Published var numberReg = ""
    @Published var remarks = ""
    
    var yearDict: [String]{
        var tempYearDict = ((year-100)...year).reversed().map { String($0) }
        tempYearDict.insert(defaultValue, at: 0)
        return tempYearDict
    }
    
    var simpleModelDict: [String]{
        var newDict: [String] = [defaultValue]
            for i in (0 ..< modelDict.count){
                newDict.append(modelDict[i].name)
            }
            return newDict
    }
    
    var simpleManufacturerDict: [String]{
        var newDict: [String] = [defaultValue]
            for i in (0 ..< manufacturerDict.count){
                newDict.append(manufacturerDict[i].brand)
            }
            return newDict
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
        newCar.fuelVolume = Float(self.fuelVolume) ?? 0

        do {
            try context.save()
            print("Car saved.")
            //            presentationMode.wrappedValue.dismiss()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isFuelType() -> Bool {
        return (selectedFuelTypeIndex != 0 ? true : false)
    }
    
    func isTransmissionType() -> Bool {
        return (selectedTransmissionIndex != 0 ? true : false)
    }
  
    func isModel() -> Bool {
        return (selectedModelIndex != 0 ? true : false)
    }
    
    func isManufacturer() -> Bool {
        return (selectedManufacturerIndex != 0 ? true : false)
    }
    
    func isCountry() -> Bool {
        return (selectedCountryIndex != 0 ? true : false)
    }
    
    func isYear() -> Bool {
        return (selectedYearIndex != 0 ? true : false)
    }
    
    func isFuelVolume() -> Bool {
        return ((fuelVolume != ""&&fuelVolume != "0"&&validateFuelVolume()) ? true : false)
    }
    func isHorsePower() -> Bool {
        return ((horsePower != ""&&horsePower != "0"&&validateHorsePower()) ? true : false)
    }
    func isMileage() -> Bool {
        return ((mileage != ""&&validateMileage()) ? true : false)
    }

    func validateFuelVolume() -> Bool {
        return ((testWholeNumber.evaluate(with: fuelVolume)||testFractionalNumber.evaluate(with: fuelVolume)) ? true : false)
    }
    func validateHorsePower() -> Bool {
        return ((testWholeNumber.evaluate(with: horsePower)||testFractionalNumber.evaluate(with: horsePower)) ? true : false)
    }
    func validateMileage() -> Bool {
        return ((testWholeNumber.evaluate(with: mileage)||testFractionalNumber.evaluate(with: mileage)) ? true : false)
    }
    func isNumberRegValid() -> Bool {
        switch selectedCountryIndex{
        case 1: // Russia
            return testRussiaRegNumber.evaluate(with: numberReg)
        case 2: // Belarus
            return testBelarusRegNumber.evaluate(with: numberReg)
        case 3: // Ukraine
            return testUkraineRegNumber.evaluate(with: numberReg)
        default:
            return testDefaultRegNumber.evaluate(with: numberReg)
        }
    }

    

    func validateNumberReg() -> Bool {
        return ((testWholeNumber.evaluate(with: mileage)||testFractionalNumber.evaluate(with: mileage)) ? true : false)
    }
    
    var promptFuelVolume: String {
        return validateFuelVolume() ? " " : "Введите значение больше нуля и не более одного знака после запятой"
    }
    var promptHorsePower: String {
        return validateHorsePower() ? " " : "Введите значение больше нуля и не более одного знака после запятой"
    }
    var promptMileage: String {
        return validateMileage() ? " " : "Введите не более одного знака после запятой"
    }
    var promptNumberReg: String {
        if isNumberRegValid(){
            return " "
        }
        else{
            switch selectedCountryIndex{
                case 1: // Russia
                    return "Введите номер в формате А123АА 77"
                case 2: // Belarus
                    return "Введите номер в формате 1234АА 7"
                case 3: // Ukraine
                    return "Введите номер в формате AA 1234AA"
                default:
                    return " "
                }
        }
    }
    
    var isReadyInsert: Bool {
        if !isMileage() ||
            !isFuelType() ||
            !isFuelVolume() ||
            !isTransmissionType() ||
            !isHorsePower() ||
            !isModel() ||
            !isManufacturer() ||
            !isNumberRegValid(){
            return false
        } 
        return true
    }
}
