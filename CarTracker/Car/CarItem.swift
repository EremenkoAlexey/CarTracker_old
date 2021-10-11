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
    @Binding var field: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                TextField(placeHolder, text: $field).autocapitalization(.none)
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


struct CarItem_Previews: PreviewProvider {
    static var previews: some View {
            Analytics().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
