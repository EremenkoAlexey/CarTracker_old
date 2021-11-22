//
//  Car+CoreDataProperties.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }
    // service columns
    @NSManaged public var id: UUID?
    @NSManaged public var dateAdded: Date
    @NSManaged public var dateUpdate: Date
    @NSManaged public var isArchive: Bool
    
    //list columns
    @NSManaged public var fuelType: String
    @NSManaged public var transmissionType: String
    
    //slider columns
    @NSManaged public var fuelVolume: Float
    
    //textfield float
    @NSManaged public var horsePower: Float
    @NSManaged public var mileage: Float
    
    //textfield string
    @NSManaged public var numberVIN: String?
    
    //
    @NSManaged public var year: String?
    @NSManaged public var country: String?
    
    // TBD
    @NSManaged public var numberReg: String?

    @NSManaged public var manufacturer: String
    @NSManaged public var model: String
    @NSManaged public var district: String?
    @NSManaged public var remark: String?
    
    // TODO:
    @NSManaged public var picture: Data?
    @NSManaged public var color: String?
    
}

extension Car : Identifiable {

}
