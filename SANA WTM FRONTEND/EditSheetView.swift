//
//  EditSheetView.swift
//  SANA WTM FRONTEND
//
//  Created by Tanvi Poondota on 7/28/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
    
    
struct EditSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var id: String
    @State var eventname: String
    @State var formaddress: String
    @State var selectbubble = ""
    @State var start_time: Date
    @State var end_time: Date
    @State var formdescription: String
    
    init(id: String, name: String, address: String, start_time: Date, end_time: Date, description: String) {
        _id = State(initialValue: id)
        _eventname = State(initialValue: name)
        _formaddress = State(initialValue: address)
        _start_time = State(initialValue: start_time)
        _end_time = State(initialValue: end_time)
        _formdescription = State(initialValue: description)
        }
    
    @State private var isExpanding = false
    
    //calendar view variables
    @State var currentTime = Date()
    var  closedRange = Calendar.current.date(byAdding: .year, value:  -1, to: Date())!
    func formatDate()->  String{
        let components = Calendar.current.dateComponents([.hour,.minute, .day, .month, .year], from: currentTime)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let day = components.day ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        
        return  "\(day)-\(month)-\(year) (\(hour): \(minute))"
    }
   
    
    var body: some View {
        
        ZStack{
            Color(red: 0.08235, green: 0.12549, blue: 0.12941)
                .ignoresSafeArea()
        
        VStack{
            Spacer()
            Spacer()
            Spacer()

            Text("Manage your Event")
                .foregroundColor(.white)
                .bold()
            Spacer()
//                NavigationView{
                    Form{
                        Section(header: Text("Edit Event Details").foregroundColor(Color.white)) {
                            TextField("", text:$eventname)
                            TextField("Address: ", text: $formaddress)
                            DatePicker("Start", selection: $start_time)
                            DatePicker("End", selection: $end_time)
                            TextField("Description", text: $formdescription)
                        }
                        
                        Button(action: {
                            dismiss()
                            viewRouter.currentPage = .page1
                            firestoreManager.updateEvent(event_id: id, event_name: eventname, event_address: formaddress, event_start_time: start_time, event_end_time: end_time, event_description: formdescription)
                            
                        }){
                            Text("Update Event")
                        }
                        
                        Button(action: {
                            firestoreManager.deleteEvent(event_id: id)
                            viewRouter.currentPage = .page1
                            dismiss()
                        }){
                            Text("Delete Event")
                                .foregroundColor(.red)
                                .frame(alignment: .center)
                        }
                    }

            Spacer()
            Spacer()
            
            Text("RSVPs")
                .foregroundColor(.white)
                .bold()
            
            Spacer()
            
            
                        
        }
        }
    
    }
}
