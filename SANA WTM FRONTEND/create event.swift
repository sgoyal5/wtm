//
//  create event.swift
//  wtm!
//
//  Created by Sana Goyal on 7/12/22.
//

import SwiftUI
struct BubbleList: Identifiable{
    let id = UUID()
    let bubble: String
    var isselected: Bool
}

struct create_event: View {
    @EnvironmentObject var firestoreManager: FirestoreManager

    @EnvironmentObject var viewRouter: ViewRouter
    @State private var bubbles = [
        BubbleList(bubble: "wtm", isselected: false),
    BubbleList(bubble: "tomatoes", isselected: false)
    
    ]
    
    @State var eventname = ""
    @State var address = ""
    @State var selectbubble = ""
    @State var description = ""
    @State var start_time = Date()
    @State var end_time = Date()
    
    
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
                    Image(systemName: "arrow.left")
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
            Text("Create a New Event")
                .foregroundColor(.white)
        
               
                Form{
                    Section{
                        TextField("Event Name", text: $eventname)
                            
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
                    Section{
                        Button(action: {
                            viewRouter.currentPage = .page1
                            
                            firestoreManager.createEvent(event_name: eventname, event_address: address, event_start_time: start_time, event_end_time: end_time, event_description: description)
                            
                            //clears the text fields on click "create event"
                            eventname = ""
                            address = ""
                            start_time = currentTime
                            end_time = currentTime
                            description = ""
                            
                        }){
                            Text("Create Event")
                        }
                            
                            
                            
                    }
                    
                }
                .foregroundColor(Color.black)
                .background(Color.yellow)
            
            
            
        }
        }
    
    }
}

        
   

struct create_event_Previews: PreviewProvider {
    static var previews: some View {
        create_event().environmentObject(ViewRouter())
    }
}

