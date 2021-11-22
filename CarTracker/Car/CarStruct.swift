//
//  CarItem.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 08.10.2021.
//

import SwiftUI

struct Manufacturer: Decodable {
    let brand: String
    let models: [Model]
}

struct Model: Decodable {
    let name: String
}
struct CarModels: View {
    
    @Binding var manufacturerPickerValue: Int
    var manufacturerDictionary: [Manufacturer]
    @Binding var modelPickerValue: Int
    var modelDictionary: [Model]
    

    var body: some View {
        VStack {
//            if model.selectedManufacturer == -1 {
//                Text("No Brand Selected")
//            } else {
//                Text("\(model.carData[model.selectedManufacturer].brand)")
//            }
            HStack{
                
                Image(systemName: "tag")
                    .foregroundColor(.gray)
                    .font(.headline)
                Picker(selection: $manufacturerPickerValue, label: Text("Марка")) {
                    Text(defaultValue)
                        .tag(-1)

                    ForEach(0 ..< manufacturerDictionary.count
                    ) { carIndex in
                        Text(self.manufacturerDictionary[carIndex].brand)
                            .tag(carIndex)
                        }
                    }
                }
            }
            

            if manufacturerPickerValue != -1 {
                HStack{
                    Image(systemName: "car")
                        .foregroundColor(.gray)
                        .font(.headline)
                    Picker(selection: $modelPickerValue, label: Text("Модель")) {
                        Text(defaultValue)
                            .tag(-1)

                        ForEach(0 ..< modelDictionary.count, id: \.self) { modelIndex in
                            Text(self.modelDictionary[modelIndex].name)
                                .tag(modelIndex)
                        }
                    }
                }
            }
    }
}

struct SmallCarCard: View {
    @ObservedObject var car: Car
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
            VStack(alignment: .leading){
                HStack{
                    Text("\(car.manufacturer) ")
                    Text("\(car.model)")
                }
                .font(.headline)
                .padding()
                Spacer()
                HStack{
                    Text("\(car.transmissionType)")
                    Text("\(AddAbbr(String(car.horsePower), "л.с."))")
                    Text("\(AddAbbr(String(car.mileage), "км."))")
                }
                .font(.subheadline)
                .padding()
            }
        }
        .frame(width: 300, height: 100)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

struct InsertCarCard: View {
    @Binding var showSheet: Bool
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
            VStack{
                Text("Добавить авто")
                Button(action: {
                    print("Open order sheet")
                    showSheet = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                })
            }
        }
        .frame(width: 300, height: 100)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

struct EntryField: View {

    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    var keyboard: String?
    @Binding var field: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                if keyboard == "number"{
                    TextField(placeHolder, text: $field)
                        .keyboardType(.decimalPad)
                }
                else{
                    TextField(placeHolder, text: $field)
                        .disableAutocorrection(true)
                        .autocapitalization(.allCharacters)
                }
            }
            .padding(8)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}

struct RoundEntryField: View {

    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    var keyboard: String?
    @Binding var field: String
    var isValid: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                if keyboard == "number"{
                    TextField(placeHolder, text: $field)
                        .keyboardType(.decimalPad)
                }
                else{
                    TextField(placeHolder, text: $field)
                        .disableAutocorrection(true)
                        .autocapitalization(.allCharacters)
                        

                }
                
            }
            .padding(8)
//            .background(Color(UIColor.secondarySystemBackground))
//            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(isValid == true ? "DarkGreen" : "DarkYellow"),
                                                                       Color(isValid == true ? "LightGreen" : "LightYellow")]),
                                           startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                    
            )
            if prompt != ""{
                Text(prompt)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
            }

        }
    }
}


struct EntrySlider: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: Float
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                Text(placeHolder)
                Spacer()
                Text("\(String(Int(field)))")
            }
            .padding(8)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Slider(
                value: $field,
                in: 40...100,
                step: 1)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
        
    }
}

struct RoundEntryWheel: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    var dictionary : [String]
    @Binding var field: Int
    @Binding var selector: Bool
    var isValid: Bool

    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 5) {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                Text(placeHolder)
                Spacer()
                    Button(action: {
                        selector.toggle()
                    }) {
                        Text(String(dictionary[field]))
                            .foregroundColor(.gray)
                    }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(8)
//            .background(Color(UIColor.secondarySystemBackground))
//            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(isValid == true ? "DarkGreen" : "DarkYellow"),
                                                                       Color(isValid == true ? "LightGreen" : "LightYellow")]),
                                           startPoint: .leading, endPoint: .trailing), lineWidth: 3))

                if prompt != ""{
                    Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                }
        }
    }
}

struct EntryWheel: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    var dictionary : [String]
    @Binding var field: Int
    @Binding var selector: Bool

    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 5) {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                Text(placeHolder)
                Spacer()
                    Button(action: {
                        selector.toggle()
                    }) {
                        Text(String(dictionary[field]))
                            .foregroundColor(.gray)
//                        if field != -1 {
//                            Text(String(dictionary[field]))
//                                .foregroundColor(.gray)
//                        }
//                        else{
//                            Text(defaultValue)
//                                .foregroundColor(.gray)
//                        }
                    }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(8)
//            .foregroundColor(.primary)
//            .background(Color(UIColor.secondarySystemBackground))
//            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))

            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}

struct WheelKeyboard: View {
    
    @Binding var pickerValue: Int
    @Binding var showSelector:Bool
    var placeholder: String
    var dictionary: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Divider()
            HStack{
                Text(placeholder)
                .padding(10)
                Spacer()
                Button(action: {showSelector.toggle()}) {
                    Text("Готово")
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
                Picker(selection: $pickerValue, label: Text(placeholder)) {
//                    Text(defaultValue)
//                        .tag(0)

                    ForEach(0 ..< dictionary.count, id: \.self) {
                        Text(dictionary[$0]).tag($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
        }
    }
        
}





//struct CarItem_Previews: PreviewProvider {
//    static var previews: some View {
//        Analytics().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
