//
//  CarModel.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 11.10.2021.
//

import Foundation
import CoreData

class CarModel : ObservableObject{

    let makeDict = ["Renault", "BMW", "Volkswagen", "Audi", "Other"]
    let modelDict = ["Sandero", "i3", "Touareg", "A5", "Other"]
    let yearDict = ["1995", "2018", "2019", "2020", "Other"]
    let districtDict = ["78", "47", "178", "198", "Other"]
    let countryDict = ["Russia", "Belarus", "Ukraine", "Georgia", "Other"]
    let fuelTypeDict = ["Бензин", "Дизель", "Гибрид", "Электро"]
    let transmissionDict = ["АКПП", "МКПП"]
    
//    public var transmissionList = [
//        transmission(name: "АКПП"),
//        transmission(name: "МКПП")
//    ]

    @Published var transmissionChoice: String? = nil
    @Published var fuelTypeChoice: String? = nil

    
    
    @Published var selectedMakeIndex = 0
    @Published var selectedModelIndex = 0
    @Published var selectedYearIndex = 0
    @Published var selectedCountryIndex = 0
    @Published var selectedDistrictIndex = 0
    @Published var selectedFuelTypeIndex = 0
    @Published var selectedTransmissionIndex = 0

    @Published var fuelVolume = ""

    @Published var horsePower = ""
    @Published var mileage = ""
    @Published var numberVIN = ""
    @Published var numberReg = ""
    //@State var color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    @Published var remarks = ""
    
    func SaveCar(_ context: NSManagedObjectContext){
//        guard self.incomeValue != "" else {return}
        let newCar = Car(context: context)
        
        newCar.make = self.makeDict[self.selectedMakeIndex]
        newCar.model = self.modelDict[self.selectedModelIndex]
        newCar.year = self.yearDict[self.selectedYearIndex]
        newCar.country = self.countryDict[self.selectedCountryIndex]
        newCar.id = UUID()
        newCar.remark = self.remarks
        newCar.dateAdded = Date()
        newCar.dateUpdate = Date()
        newCar.horsePower = Float(self.horsePower) ?? 0
        newCar.numberReg = self.numberReg
        newCar.numberVIN = self.numberVIN
        newCar.district = self.countryDict[self.selectedDistrictIndex]
        
        newCar.transmissionType = self.transmissionDict[self.selectedTransmissionIndex]

        newCar.fuelVolume = self.fuelVolume
        newCar.mileage = Float(self.mileage) ?? 0
        newCar.fuelType = self.fuelTypeDict[self.selectedFuelTypeIndex]
        
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

}
