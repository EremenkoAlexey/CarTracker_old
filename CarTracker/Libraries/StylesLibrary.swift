//
//  StylesLibrary.swift
//  CarTracker
//
//  Created by Aleksei Eremenko on 10.11.2021.
//

//
//  StylesLibrary.swift
//  RememberMe
//
//  Created by Aleksei Eremenko on 24.11.2020.
//

import Foundation
import SwiftUI


struct RoundGradientYellowToGreen: View{
    var isValid: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(LinearGradient(gradient: Gradient(colors: [Color(isValid == true ? "DarkGreen" : "DarkYellow"),
                                                               Color(isValid == true ? "LightGreen" : "LightYellow")]),
                                   startPoint: .leading, endPoint: .trailing), lineWidth: 3)
    }
}

struct RoundYellowToGreenButton: ButtonStyle {
    var isValid: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .disabled(!isValid)
            .background(LinearGradient(gradient: Gradient(colors: [Color(isValid == true ? "DarkGreen" : "DarkYellow"),
                                                                   Color(isValid == true ? "LightGreen" : "LightYellow")]),
                                       startPoint: .leading, endPoint: .trailing)).opacity(configuration.isPressed ? 0.5 : 1)
        
            .cornerRadius(30)
            .padding(.horizontal, 20)
 
    } 
}

struct WhiteBoldButtonText: View{
    var textValue: String
    
    var body: some View {
        Text(textValue)
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.white)
    }
    
}


