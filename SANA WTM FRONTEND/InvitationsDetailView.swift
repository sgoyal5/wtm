//
//  EditSheetView.swift
//  SANA WTM FRONTEND
//
//  Created by Tanvi Poondota on 7/28/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct InvitationsDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()
    @EnvironmentObject var viewRouter: ViewRouter
        
    @State var id: String
    @State var inv_eventname: String
    @State var inv_address: String
//    @State var selectbubble = ""
    @State var inv_start_time: Date
    @State var inv_end_time: Date
    @State var inv_description: String
   
    
    var body: some View {
        
        ZStack{
            Color(red: 0.08235, green: 0.12549, blue: 0.12941)
                .ignoresSafeArea()
        
        VStack{
            

            Text("Event Details")
                .foregroundColor(.white)
                .bold()
            
            Text("Event Name: \(inv_eventname)")
            Text("Event Address: \(inv_address)")
            Text("Event Start Time:")
            Text(inv_start_time, style: .date)
            Text(inv_start_time, style: .time)
            Text("Event End Time:")
            Text(inv_end_time, style: .date)
            Text(inv_end_time, style: .time)
            Text("Event Description: \(inv_description)")
            
            
                        
        }
        }
    
    }
}
