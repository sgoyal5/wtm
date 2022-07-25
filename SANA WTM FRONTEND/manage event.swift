//
//  create event.swift
//  wtm!
//
//  Created by Sana Goyal on 7/12/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

//struct BubbleList: Identifiable{
//    let id = UUID()
//    let bubble: String
//    var isselected: Bool
//}

struct manage_event: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()


    @EnvironmentObject var viewRouter: ViewRouter
    @State private var bubbles = [
        BubbleList(bubble: "wtm", isselected: false),
    BubbleList(bubble: "tomatoes", isselected: false)
        
    ]
    
    @State var eventname = ""
    @State var address = ""
    @State var selectbubble = ""
    @State var start_time = Date()
    @State var end_time = Date()
    @State var description = ""
    
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
            
            HStack{
                
            
                Button(action:{
                    
                    viewRouter.currentPage = .page1
                    
                    
                }){
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width:25, height: 25)
                        .padding()
                    
                }
                
                   
    
                Spacer()
                
                Text("wtm")
                    
                    .navigationTitle("wtm")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    
                    
                
                Spacer()
                Text("SG")
                    .frame(width: 35, height: 35)
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                       
                        Circle()
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 60, height:100)
                            .foregroundColor(.white)
                    
                            .padding(10)
                    )
                
                
            }
            
            Text("Manage your Event")
                .foregroundColor(.white)
                .bold()
            Spacer()
            Spacer()
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    viewRouter.currentPage = .page5
                }){
                    Text("Event Details")
                }
                    .foregroundColor(Color.gray)
                    .font(.headline)
                    .padding()
                Spacer()
                Button(action: {
                    viewRouter.currentPage = .page6
                }){
                    Text("RSVPS")
                }
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .padding()
                Spacer()
            }
        
               
                NavigationView{
                    
                    Form{
                        Section{
                            TextField(("Event Name"), text: $eventname)
                                
                            TextField("Address", text: $address)
                            DisclosureGroup("Select Bubbles", isExpanded: $isExpanding){
                                VStack{
                                    List($bubbles){ $bubble in
                                        HStack{
                                            Image(systemName: bubble.isselected ?  "checkmark.square"  : "square")
                                                .onTapGesture {
                                                    bubble.isselected.toggle()
                                                }
                                            Text(bubble.bubble)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    }
                                }
                            }
                            
                        }
                        
                        Section{
                            DatePicker("Start", selection: $start_time)
                            DatePicker("End", selection: $end_time, in: Date()...)
                            TextField("Description", text: $description)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            
                        }
                        Button(action: {
                            
                            viewRouter.currentPage = .page1
                            
                            let event = MyVariables.event_id
                            firestoreManager.updateEvent(event_id: event, event_name: eventname, event_address: address, event_description: description)
                            
//                            firestoreManager.updateEvent(event_id: event_id, event_name: eventname)
                            
                            //firestoreManager.editEvent(event_id)
                            
                        }){
                            Text("Update Event")
                        }
                        
                        Button(action: {
                            let event = MyVariables.event_id
                            firestoreManager.deleteEvent(event_id: event)
                            viewRouter.currentPage = .page1
                        }){
                            Text("Delete Event")
                                .foregroundColor(.red)
                                .frame(alignment: .center)
                        }
                            
                        
                    }
                    }
                    
                   
                    
            Spacer()
            Spacer()
                    
                .foregroundColor(Color.black)
                .background(Color.yellow)
            
                
            
            
        }
        }
    
    }
}

struct manage_event_Previews: PreviewProvider {
    static var previews: some View {
        manage_event().environmentObject(ViewRouter())
    }
}
