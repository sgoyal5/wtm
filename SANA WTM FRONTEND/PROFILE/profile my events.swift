//
//  edit profile.swift
//  account
//
//  Created by Sana Goyal on 7/4/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct eventView: Identifiable{
    let id = UUID()
    let title: String
    let host: String
    let location: String
    let description: String
    let date: String
    let starttime: String
    
}
struct MyEvents: Identifiable {
    var id: String = ""
    var event_name: String = ""
    var event_address: String = ""
    var event_start_time: Date
    var event_end_time: Date
    var event_description: String = ""
}

struct profile_my_events: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()

    @EnvironmentObject var viewRouter: ViewRouter
    @State var event_id = ""
    @State private var event = [
        eventView(title: "anikas 19th", host: "Anika Bhadriraju Event", location: "lark", description: "bring nice clothes", date: "july 21", starttime: "10 pm")
    ]
    
    func buttonPressed(){
        
        print("button pressed")
    }
    @State private var upcomingevents: Bool = false
    @State private var invitations: Bool = false
    var isOn = true
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var username = ""
    @State private var school = ""
    
    var body: some View {
    
        ZStack{
            Color(red: 0.08235, green: 0.12549, blue: 0.12941)
                .ignoresSafeArea()
        
        VStack{
            HStack{
                Spacer()
            
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fill)
                    .frame(width:25, height: 25)
                   
    
                Spacer()
                
                Text("wtm")
                    
                    .navigationTitle("wtm")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    
                    
                
                Spacer()
                Image(systemName: "gear")
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fill)
                    .frame(width:25, height: 25)
                    
                Spacer()
            }
           
        
                    
            HStack{
              
                
                Spacer()
                
                Text("SG")
                    .frame(width: 35, height: 35)
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                       
                        Circle()
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 100, height:100)
                            .foregroundColor(.white)
                    
                            .padding(10)
                    )
                Spacer()
              
               
                
                
                VStack{
                    Text("\(firestoreManager.first_name)")
                        .padding(0.9)
                        
                        .font(.system(size:27, weight: .bold))
                        .foregroundColor(.white)
                    
                        
                  
                    Text("\(firestoreManager.last_name)")
                        .padding(0.9)
                        .font(.system(size:27, weight: .bold))
                        .foregroundColor(.white)
                        
                    Text("@\(firestoreManager.username)")
                        .padding(0.75)
                        .font(.system(size:15))
                        .foregroundColor(.white)
                    
                    
                    
                }
                    
              Spacer()
                       
            }
          
            
            Text("EVENTS")
                .padding(.top)
                .foregroundColor(.white)
            HStack{
                Spacer()
                Button(action: {
                    viewRouter.currentPage = .page1
                }){
                    Text("My Events")
                }
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .padding()
                

                Button(action: {
                    viewRouter.currentPage = .page2
                }){
                    Text("Upcoming")
                }
                    .foregroundColor(Color.gray)
                    .font(.headline)
                    .padding()
                Button(action: {
                    viewRouter.currentPage = .page3
                }){
                    Text("Invitations")
                }
                    .foregroundColor(Color.gray)
                    .font(.headline)
                    .padding()
                
//
                                  
                          
                Spacer()
                
            }
            
            
                                        
            Spacer()
            VStack{
                NavigationView{
                    
                    
                    List(model.list) { item in
                        HStack{
                            Button(action:{
                                
                                viewRouter.currentPage = .page5
                                
                            }){
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                            }
                        
                            Spacer()
                            
                            VStack{
                                Text(item.event_name)
                                    .bold()
                                Text("@" + item.event_address)
                                    .frame(alignment: .leading)
                                    
                                Text(item.event_description)
                            
                            }
                            
                            Spacer()
                            VStack{
                                Spacer()
                                Text(item.event_start_time, style: .date)
                                Text(item.event_start_time, style: .time)
                                Spacer()
                                
                            }
                                
                            }
                        
                    }.background(.black)
                    
                }
                
            }.background(.black)
            
            
            
            
            /* from old test-wtm
             
             VStack{
                 List(model.list) { item in
                     HStack{
                         
                         Button(action:{
                             buttonPressed()
                             //model.editMyEvent(eventToUpdate: item)
                         }){
                             Image(systemName: "square.and.pencil")
                                 .resizable()
                                 .frame(width: 20, height: 20)
                                 .foregroundColor(.black)
                                 .padding()
                             
                         }
                         
 //                        Image(systemName: "square.and.pencil")
 //                            .resizable()
 //                            .frame(width: 30, height: 30)
                         
                         
                         
                         Spacer()
                         
                         VStack{
                             Text(item.event_name)
                             Text("@" + item.event_address)
                             Text(item.event_description)
                         
                        }
                         Spacer()
                         
                         VStack{
                             
                             Text(item.event_start_time, style: .date)
                                 .padding()
                             Text(item.event_start_time, style: .time)
                             Spacer()
                             Spacer()
                         }
                         }
                 }.background(.black)
             }.background(.black)
             
             */
            
            
            
            
            
            Spacer()
            
            HStack{
                Spacer()
                Button(action:{
                    
                    viewRouter.currentPage = .page4
                    
                    
                }){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding()
                    
                }
            }
            
            
        }
        
    }
    }

}


struct profile_my_events_Previews: PreviewProvider {
    static var previews: some View {
        profile_my_events().environmentObject(ViewRouter())
    }
}
