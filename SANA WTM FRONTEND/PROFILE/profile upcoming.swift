//
//  edit profile.swift
//  account
//
//  Created by Sana Goyal on 7/4/22.
//

import SwiftUI
struct eventUpcomingView: Identifiable{
    let id = UUID()
    let title: String
    let host: String
    let location: String
    let description: String
    let date: String
    let starttime: String
    
}

struct profile_upcoming: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager

    @EnvironmentObject var viewRouter: ViewRouter
    @State private var eventupcoming = [
        eventUpcomingView(title: "anikas 19th", host: "Anika Bhadriraju Event", location: "lark", description: "bring nice clothes", date: "july 21", starttime: "10 pm")
    ]
    
    
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
                    .foregroundColor(Color.white)
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
                    List(eventupcoming){ eventlist in
                        HStack{
                        
                            Spacer()
                            
                            VStack{
                                Text(eventlist.title + " event")
                                    .bold()
                                Text("@ " + eventlist.location)
                                    .frame(alignment: .leading)
                                    
                                Text(eventlist.description)
                            
                            }
                            Spacer()
                            VStack{
                                Spacer()
                                Text(eventlist.date)
                                    
                                    .textCase(.uppercase)
                                Text(eventlist.starttime)
                                    .textCase(.uppercase)
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

struct profile_upcoming_Previews: PreviewProvider {
    static var previews: some View {
        profile_upcoming().environmentObject(ViewRouter())
    }
}



