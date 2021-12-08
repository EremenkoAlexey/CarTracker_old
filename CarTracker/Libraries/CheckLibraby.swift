//
//  CheckLibraby.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 08.10.2021.
//

import Foundation

// tests 0-7 digits olny
let testWholeNumber = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{0,7}$")

// tests 0-7 digits, 1 coma and 1 digit after it
let testFractionalNumber = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{1,7}[\\u002C][0-9]{1}$")

let testDefaultRegNumber = NSPredicate(format: "SELF MATCHES %@",
                              "[a-z0-9]{1,15}")

let testRussiaRegNumber = NSPredicate(format: "SELF MATCHES %@",
                             "^[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0423\\u0425]{1}[0-9]{3}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0423\\u0425]{2}\\u0020([0-9]{2}|[1-9]{1}[0-9]{2})$")

let testUkraineRegNumber = NSPredicate(format: "SELF MATCHES %@",
                             "^[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}\\u0020[0-9]{4}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}$")

let testBelarusRegNumber = NSPredicate(format: "SELF MATCHES %@",
                             "^[0-9]{4}[\\u0410\\u0412\\u0415\\u041A\\u041C\\u041D\\u041E\\u0420\\u0421\\u0422\\u0425\\u0406]{2}\\u0020[0-8]{1}$")


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
