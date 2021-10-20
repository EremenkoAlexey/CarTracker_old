//
//  CarList.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 28.09.2021.
//

import SwiftUI


struct CarList: View {
    @State private var field : String = ""
//        .textCase(.uppercase)

    var body: some View {
//        VStack(spacing: 0) {
//            Spacer()
//            Divider()
//            Picker(selection: $age, label: Text("Age")) {
//                 ForEach(0 ..< 100) { number in
//                      Text("\(number)")
//                 }
//            }.pickerStyle(WheelPickerStyle())
//            .frame(maxWidth: .infinity)
//            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
//        }
        TextField("test", text: $field)
//                        .autocapitalization(.none)
            .disableAutocorrection(true)
            .autocapitalization(.allCharacters)
//            .textCase(.uppercase)//        WheelKeyboard(year: $age)
    }
}

struct CarList_Previews: PreviewProvider {
    static var previews: some View {
        CarList()
    }
}
