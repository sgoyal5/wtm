//
//  wtm_App.swift
//  wtm!
//
//  Created by Ananya Garg on 6/17/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      UITableView.appearance().backgroundColor = UIColor(red: 0.08235, green: 0.12549, blue: 0.12941, alpha: 100)
      UIListContentView.appearance().backgroundColor = UIColor(red: 0.08235, green: 0.12549, blue: 0.12941, alpha: 100)
      
    FirebaseApp.configure()

    return true
  }
}

@main
struct wtm_App: App {
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}

