//
//  edit profile.swift
//  account
//
//  Created by Sana Goyal on 7/4/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

//
//struct Invitations: Identifiable {
//    var id: String = ""
//    var inv_name: String = ""
//    var inv_address: String = ""
//    var inv_start_time: Date
//    var inv_end_time: Date
//    var inv_description: String = ""
//}

struct profile_invitations: View {
    @State private var showingDetailSheet = false

    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()
    @EnvironmentObject var viewRouter: ViewRouter
   
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
                    .foregroundColor(Color.gray)
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
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .padding()
                
//
                                  
                          
                Spacer()
                
            }
            
            
                                        
            Spacer()
            VStack{
                NavigationView{
                
                    List(model.invitationslist) { item in
                        HStack{
                            Button(action:{
                                showingDetailSheet.toggle()
                                
                            }){
                                Text("View Details")
                                    .frame(width: 30, height: 30)
                                
//                            }.fullScreenCover(isPresented: $showingSheet) {
                            }.sheet(isPresented: $showingDetailSheet) {
                                InvitationsDetailView(id: item.id, event_eventname: item.event_name, event_address: item.event_address, event_start_time: item.event_start_time, event_end_time: item.event_end_time, event_description: item.event_description)
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
            
            Spacer()
            
            
            
            
        }
        
    }
    }
}

struct profile_invitations_Previews: PreviewProvider {
    static var previews: some View {
        profile_invitations().environmentObject(ViewRouter())
    }
}




