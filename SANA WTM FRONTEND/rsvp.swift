//
//  rsvp.swift
//  wtm!
//
//  Created by Sana Goyal on 7/24/22.
//

import SwiftUI
struct rsvplist: Identifiable{
    let id = UUID()
    let username: String
    var name: String
    var rsvp: String
    var avatar: String
}

struct rsvp: View {
    @State private var rsvps: [rsvplist] = [
        rsvplist(username: "sarayuy", name: "Sarayu Yenumula", rsvp: "Yes", avatar: "sarayu"),
        rsvplist(username: "tanvipoondota", name: "Tanvi Poondota", rsvp: "No", avatar: "tanvi")
    
    ]
                              
    
    @EnvironmentObject var viewRouter: ViewRouter
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
            List(){
                ForEach(rsvps, id: \.id) { rsvps in
                HStack{
                    Image(rsvps.avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                        .border(.black)
                    VStack (alignment: .leading, spacing: 5){
                    Text(rsvps.name)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    Text("@"+rsvps.username)
                        .foregroundColor(Color.gray)
                    
                    }
                    Spacer()
                    Text(rsvps.rsvp)
                        .foregroundColor(.black)
                    
                }
                
            }
           
                
        }
        }
    }
}

struct rsvp_Previews: PreviewProvider {
    static var previews: some View {
        rsvp().environmentObject(ViewRouter())
    }
}
}

