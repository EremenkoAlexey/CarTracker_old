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
        
        OldEntryField(sfSymbolName: "number",
                   placeHolder: "Гос. номер",
                   prompt: "newCar.promptNumberReg",
                   field: $field)
    }
}

struct CarList_Previews: PreviewProvider {
    static var previews: some View {
        CarList()
    }
}
