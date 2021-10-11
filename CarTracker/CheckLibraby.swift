//
//  CheckLibraby.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 08.10.2021.
//

import Foundation

func CheckEmpty(_ value: String?) -> String{
   return value != nil ? String(value!) : ""
}

func AddAbbr(_ value: String?, _ abbr: String) -> String{
    let retValue: String = CheckEmpty(value)
    return retValue.isEmpty ? retValue : ", " + String(retValue)+" \(abbr)"

}

func AddComa(_ value: String?) -> String{
    let retValue: String = CheckEmpty(value)
    return retValue.isEmpty ? retValue : String(retValue)+","
}
