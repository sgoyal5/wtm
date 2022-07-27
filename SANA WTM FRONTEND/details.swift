//
//  details.swift
//  SANA WTM FRONTEND
//
//  Created by Tanvi Poondota on 7/27/22.
//

import SwiftUI

struct details: View {
    var name: String
    var address: String
    var description: String


    var body: some View {
        Text("Event Name: \(name)")
        Text("Event Address: \(address)")
        Text("Event Description: \(description)")

    }
}

struct details_Previews: PreviewProvider {
    static var previews: some View {
        details(name: "", address: "", description: "").environmentObject(ViewRouter())
    }
}
