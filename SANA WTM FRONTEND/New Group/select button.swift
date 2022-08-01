//
//  select button.swift
//  idk
//
//  Created by Sana Goyal on 8/1/22.
//

import SwiftUI

struct select_button: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    var body: some View {
        ZStack{
            Capsule()
                .frame(width: 175, height: 50)
                .foregroundColor(isSelected ? color: .gray)
            Text(text)
                .foregroundColor(.white)
        }
        
    }
}

struct select_button_Previews: PreviewProvider {
    static var previews: some View {
        select_button(isSelected: .constant(false), color: .white, text: "Option")
    }
}

