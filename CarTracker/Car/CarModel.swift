//
//  CarModel.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 11.10.2021.
//

import Foundation
import CoreData
import SwiftUI

class CarModel : ObservableObject{
    
    let makeDict = ["Renault", "BMW", "Volkswagen", "Audi", "Other"]
    let modelDict = ["Sandero", "i3", "Touareg", "A5", "Other"]
    let yearDict = ["1995", "2018", "2019", "2020", "Other"]
    let districtDict = ["78", "47", "178", "198", "Other"]
    
    
    let fuelTypeDict = ["Бензин", "Дизель", "Гибрид", "Электро"]
    @Published var fuelTypeChoice: String?
    //    @Published var fuelTypeChoice: String = "Бензин"
    
    let transmissionDict = ["АКПП", "МКПП"]
    //    @Published var transmissionChoice: String = "АКПП"
    @Published var transmissionChoice: String?
    
    @Published var selectedMakeIndex = 0
    @Published var selectedModelIndex = 0
    @Published var selectedYearIndex = 0
    @Published var selectedCountryIndex = 0
    @Published var selectedDistrictIndex = 0
    @Published var selectedFuelTypeIndex = 0
    @Published var selectedTransmissionIndex = 0
    
    @Published var fuelVolume : Float = 0.0
    
    @Published var horsePower = ""
    @Published var mileage = ""
    @Published var numberVIN = ""
    @Published var numberReg = ""
    
    @Published var remarks = ""
    
    @Published var year : Int = Calendar.current.dateComponents([.year], from: Date()).year!
    @Published var country : String = "Россия"
    func SaveCar(_ context: NSManagedObjectContext){
        //        guard self.incomeValue != "" else {return}
        let newCar = Car(context: context)
        
        newCar.make = self.makeDict[self.selectedMakeIndex]
        newCar.model = self.modelDict[self.selectedModelIndex]
//        newCar.year = self.yearDict[self.selectedYearIndex]
        newCar.year = String(self.year)
//        newCar.country = self.countryDict[self.selectedCountryIndex]
        newCar.country = self.country
        newCar.id = UUID()
        newCar.remark = self.remarks
        newCar.dateAdded = Date()
        newCar.dateUpdate = Date()
        newCar.horsePower = Float(self.horsePower) ?? 0
        newCar.numberReg = self.numberReg
        newCar.numberVIN = self.numberVIN
//        newCar.district = self.countryDict[self.selectedDistrictIndex]
        
        //        newCar.transmissionType = self.transmissionDict[self.selectedTransmissionIndex]
        
        newCar.transmissionType = self.transmissionChoice!
        newCar.fuelType = self.fuelTypeChoice!
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
        if fuelTypeChoice != nil{
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
        if transmissionChoice != nil{
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
    
    var isReadyInsert: Bool {
        if !isMileage() ||
            !isFuelType() ||
            !isFuelVolume() ||
            !isTransmissionType() ||
            !isHorsePower(){
            return false
        }
        return true
    }
}
