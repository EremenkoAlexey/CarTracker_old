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
            .padding(12)
            .overlay(RoundGradientYellowToGreen(isValid: isValid))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}



struct EntryWheel: View {
    var sfSymbolName: String
    var placeHolder: String
//    var dictionary : [String]
//    @Binding var field: Int
    @Binding var selector: Bool
    var isValid: Bool
    var currentValue: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 5) {
                Button(action: {
                    selector.toggle()
                }) {
                    Image(systemName: sfSymbolName)
                        .foregroundColor(.gray)
                        .font(.headline)
                    Text(placeHolder)
                        .foregroundColor(.gray)
                    Spacer()
//                    Text(String(dictionary[field]))
                    Text(currentValue)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(12)
            .overlay(RoundGradientYellowToGreen(isValid: isValid))
            
            // empty "prompt" for padding, same as in EnrtyField
            Text(" ")
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
