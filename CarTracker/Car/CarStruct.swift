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
    
    @Binding var makePickerValue: Int
    var makeDictionary: [Manufacturer]
    @Binding var modelPickerValue: Int
    var modelDictionary: [Model]
    
//    @ObservedObject private var model = ContentViewModel()

    var body: some View {
        VStack {
//            if model.selectedManufacturer == -1 {
//                Text("No Brand Selected")
//            } else {
//                Text("\(model.carData[model.selectedManufacturer].brand)")
//            }

            Picker(selection: $makePickerValue, label: Text("Марка")) {
                Text(defaultValue)
                    .tag(-1)

                ForEach(0 ..< makeDictionary.count
                ) { carIndex in
                    Text(self.makeDictionary[carIndex].brand)
                        .tag(carIndex)
//                    , id: \.self) { //value in
//                        Text(makeDictionary[$0]).tag($0)
                    }
                }
            }

//            if $makePickerValue != -1 {
                Picker(selection: $modelPickerValue, label: Text("Модель")) {
                    Text(defaultValue)
                        .tag(-1)

                    ForEach(0 ..< modelDictionary.count, id: \.self) { modelIndex in
                        Text(self.modelDictionary[modelIndex].name)
                            .tag(modelIndex)
//                        Text(makeDictionary[$0]).tag($0)

                    }
                }
//            }
//        }
    }
}

struct CarPicker: View {
    
    @Binding var pickerValue: Int
    var dictionary: [String]

    
//    @ObservedObject private var model = ContentViewModel()

    var body: some View {
        VStack {
//            if model.selectedManufacturer == -1 {
                Text("No Brand Selected")
//            } else {
//                Text("\(model.carData[model.selectedManufacturer].brand)")
//            }

//            List(
//            Picker(selection: $pickerValue, label: Text("Brand")) {
//                Text("None")
//                    .tag(-1)
//
//                ForEach(0 ..< dictionary.count) { carIndex in
//                    Text(self.model.carData[carIndex].brand)
//                        .tag(carIndex)
//                }
//            }

//            if model.selectedManufacturer != -1 {
//                Picker(selection: $model.selectedModel, label: Text("Model")) {
//                    Text("None")
//                        .tag(-1)
//
//                    ForEach(0 ..< model.models.count, id: \.self) { modelIndex in
//                        Text(self.model.models[modelIndex].name)
//                            .tag(modelIndex)
//                    }
//                }
//            }
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
                    Text("\(car.make) ")
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
//                Image(systemName: "plus.circle")
//                    .foregroundColor(.gray)
//                    .font(.headline)
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
                Text("\(String(field))")
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
                    }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(8)
            .foregroundColor(.primary)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))

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
                    ForEach(0 ..< dictionary.count, id: \.self) { //value in
                        Text(dictionary[$0]).tag($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
        }
    }
}



struct SelectionCell: View {
    
    let item: String
    @Binding var selectedItem: String?
    
    var body: some View {
        HStack {
            Text(item)
            Spacer()
            if item == selectedItem {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }.contentShape(Rectangle())
            .onTapGesture {
                self.selectedItem = self.item
            }
    }
}


struct SelectionList: View{
    var placeHolder: String
    var prompt: String
    var dictionary: [String]
    @Binding var field: String?

    var body: some View{
        Section(header: Text(placeHolder), footer: Text(prompt)) {
            List(dictionary, id: \.self) {item in
                SelectionCell(item: item, selectedItem: $field)
            }
        }
    }
}

struct CarItem_Previews: PreviewProvider {
    static var previews: some View {
        Analytics().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
