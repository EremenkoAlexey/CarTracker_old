//
//  CarInsert.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI

struct CarInsert: View {
    let makeDict = ["Renault", "BMW", "Volkswagen", "Audi", "Other"]
    let modelDict = ["Sandero", "i3", "Touareg", "A5", "Other"]
    let yearDict = ["1995", "2018", "2019", "2020", "Other"]
    let districtDict = ["78", "47", "178", "198", "Other"]
    let countryDict = ["Russia", "Belarus", "Ukraine", "Georgia", "Other"]
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode

    @Binding var showView : Bool
    
    @State var selectedMakeIndex = 0
    @State var selectedModelIndex = 0
    @State var selectedYearIndex = 0
    @State var selectedCountryIndex = 0
    @State var selectedDistrictIndex = 0

    @State var horsePower = ""
    @State var numberVIN = ""
    @State var numberReg = ""
    //@State var color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    @State var remarks = ""

    
    func SaveCar(){
//        guard self.incomeValue != "" else {return}
        let newCar = Car(context: viewContext)
        
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

//        newCar.color = self.color
//        newCar.picture = self.picture

        do {
            try viewContext.save()
            print("Car saved.")
            presentationMode.wrappedValue.dismiss()

        } catch {
            print(error.localizedDescription)
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Информауия об автомобиле")) {
                    Picker(selection: $selectedMakeIndex, label: Text("Производитель")) {
                        ForEach(0 ..< makeDict.count) {
                                Text(self.makeDict[$0]).tag($0)
                        }
                    }
                    Picker(selection: $selectedModelIndex, label: Text("Марка")) {
                        ForEach(0 ..< modelDict.count) {
                                Text(self.modelDict[$0]).tag($0)
                        }
                    }
                    Picker(selection: $selectedYearIndex, label: Text("Год выпуска")) {
//                        ForEach((1950...2021).reversed(), id: \.self){Text(String($0))
                        ForEach(0 ..< yearDict.count) {
                                Text(self.yearDict[$0]).tag($0)
                        }
                    }
                    TextField("Мощность, л.с.", text: $horsePower)
                        .keyboardType(.decimalPad)
                    
                    TextField("VIN", text: $numberVIN)
                }
                    Section(header: Text("Регистрация")) {

                    Picker(selection: $selectedCountryIndex, label: Text("Страна")) {
                        ForEach(0 ..< countryDict.count) {
                                Text(self.countryDict[$0]).tag($0)
                        }
                    }
                    Picker(selection: $selectedDistrictIndex, label: Text("Регион")) {
                        ForEach(0 ..< districtDict.count) {
                                Text(self.districtDict[$0]).tag($0)
                        }
                    }
                    TextField("Гос. номер", text: $numberReg)

                    //ColorPicker("Choose color", selection: $color)
                    
                    TextField("Примечание", text: $remarks)

                }
                
                Button(action: {SaveCar()}
                ) {
                    Text("Добавить")
                }
            }
                .navigationTitle("Добавление авто")
        }
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
