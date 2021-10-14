//
//  CarItem.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 08.10.2021.
//

import SwiftUI

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
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
            VStack{
                Text("Добавить авто")
                Image(systemName: "plus.circle")
                    .foregroundColor(.gray)
                    .font(.headline)
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
                        .autocapitalization(.none)
                        .keyboardType(.decimalPad)
                }
                else{
                    TextField(placeHolder, text: $field)
                        .autocapitalization(.none)
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
    var internalType: String
    @Binding var field: Int
    @Binding var selector: Bool
    let countryDict = ["Россия", "Беларусь", "Украина", "Другая"]

    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 5) {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                Text(placeHolder)
                Spacer()
                switch internalType{
                case "year":
                    Button(action: {
                        selector.toggle()
                    }) {
                        Text(String(field))
                    }
                case "country":
                    Button(action: {
                        selector.toggle()
                    }) {
                        Text(String(countryDict[field]))
                    }
                default:
                    Spacer()
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

struct WheelKeyboard: View {
    
    @Binding var pickerValue: Int
    @Binding var showSelector:Bool
    var placeholder: String
    var internalType: String
    
    
    let currentYear = Calendar.current.dateComponents([.year], from: Date()).year!
    let countryDict = ["Россия", "Беларусь", "Украина", "Другая"]

    
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
            switch internalType {
                case "year":
                    Picker(selection: $pickerValue, label: Text(placeholder)) {
                        ForEach(((currentYear-100)...currentYear).reversed(), id: \.self) { year in
                              Text("\(String(year))")
                         }
                    }.pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
            case "country":
                Picker(selection: $pickerValue, label: Text(placeholder)) {
                    ForEach(0 ..< countryDict.count, id: \.self) { //value in
                        Text(countryDict[$0]).tag($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
            default: Spacer()
            }
        }
    }
}

struct pickertodo: View{
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    var internalType: String
    @Binding var field: Int
    @Binding var selector: Bool
    
    var body: some View{
        Section(header: Text(placeHolder), footer: Text(prompt)) {
//            List(newCar.fuelTypeDict, id: \.self) {item in
//                SelectionCell(item: item, selectedItem: $newCar.fuelTypeChoice)
//            }
        }
    }
}

struct CarItem_Previews: PreviewProvider {
    static var previews: some View {
        Analytics().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
