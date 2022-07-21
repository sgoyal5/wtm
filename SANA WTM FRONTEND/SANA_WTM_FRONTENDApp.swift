//
//  wtm_App.swift
//  wtm!
//
//  Created by Ananya Garg on 6/17/22.
//

import SwiftUI

@main
struct wtm_App: App {
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}

