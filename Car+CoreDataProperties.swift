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

    @NSManaged public var id: UUID?
    @NSManaged public var dateAdded: Date
    @NSManaged public var dateUpdate: Date
    @NSManaged public var isArchive: Bool
    
    @NSManaged public var make: String
    @NSManaged public var model: String
    
    @NSManaged public var fuelType: String
    @NSManaged public var transmissionType: String
    @NSManaged public var fuelVolume: String?

    @NSManaged public var country: String?
    @NSManaged public var year: String?
    @NSManaged public var mileage: Float
    @NSManaged public var horsePower: Float
    @NSManaged public var numberVIN: String?
    @NSManaged public var numberReg: String?
    @NSManaged public var district: String?
    @NSManaged public var remark: String?
    
    
    @NSManaged public var picture: Data?
    @NSManaged public var color: String?
    
}

extension Car : Identifiable {

}
