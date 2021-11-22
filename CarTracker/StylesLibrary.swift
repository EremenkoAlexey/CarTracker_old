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

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing)).opacity(configuration.isPressed ? 0.5 : 1)
        
        .cornerRadius(30)
        .padding(.horizontal, 20)
        
        .font(Font.system(size: 18, weight: .medium, design: .serif))
    }
}

struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .padding(.all, 10)
        .font(Font.system(size: 18, weight: .medium, design: .serif))
    }
}

struct GreenTextStyle: TextFieldStyle {
        
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.white)
        
        .cornerRadius(30)
        .foregroundColor(Color("DarkGreen"))
        .font(Font.system(size: 18, weight: .medium, design: .serif))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing), lineWidth: 3)
        )
        .padding(.horizontal, 20)
    }
}

struct testac: View{
    var isError: Bool

    var body: some View {
        HStack{
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(isError == true ? "DarkRed" : "DarkGreen"),
                                                                   Color(isError == true ? "LightRed" : "LightGreen")]),
                                       startPoint: .leading, endPoint: .trailing), lineWidth: 3)
        )
    }
    
}

struct DefaultTextStyle: TextFieldStyle {
    var isError: Bool
    var sfSymbolName: String
    public func _body(configuration: TextField<Self._Label>) -> some View {
        
        configuration
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(30)
//        .foregroundColor(Color(""))
        .font(Font.system(size: 18, weight: .medium, design: .serif))

        .padding(.horizontal, 20)
    }
}

struct RoundedTextStyle: TextFieldStyle {
    var isError: Bool
    var sfSymbolName: String
    public func _body(configuration: TextField<Self._Label>) -> some View {
        
        configuration
//        Image(systemName: sfSymbolName)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .foregroundColor(Color("DarkGreen"))
        .font(Font.system(size: 18, weight: .medium, design: .serif))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(isError == true ? "DarkRed" : "DarkGreen"),
                                                                   Color(isError == true ? "LightRed" : "LightGreen")]),
                                       startPoint: .leading, endPoint: .trailing), lineWidth: 3)
        )
        .padding(.horizontal, 20)
    }
}

