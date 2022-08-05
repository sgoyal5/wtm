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
    @State var event_eventname: String
    @State var event_address: String
//    @State var selectbubble = ""
    @State var event_start_time: Date
    @State var event_end_time: Date
    @State var event_description: String
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var showAlert = false
    @State private var alertText = ""
   
    var body: some View {
        
        ZStack{
            Color(red: 0.08235, green: 0.12549, blue: 0.12941)
                .ignoresSafeArea()
            VStack{
                HStack{
                    
                
    //                Button(action:{
    //
    ////                    viewRouter.currentPage = .page1
    //
    //
    //                }){
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:25, height: 25)
                            .padding()
                        
    //                }
                    
                       
        
                    Spacer()
                    
                    Text("wtm")
                        
                        .navigationTitle("wtm")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Spacer()
                
                    
                }
                
                    
                HStack{
                    Spacer()
                    
                    Text("SG")
                        .frame(width: 50, height: 50)
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                           
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .frame(width: 100, height:100)
                                .foregroundColor(.white)
                                .padding()
                            )
                        
                                .padding()
                    Spacer()
                    Text("Event Name: \(event_eventname)")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                    
                }
               
                    
                Text("Your RSVP")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
    //            Capsule()
    //                .frame(width: 350, height: 50)
    //                .foregroundColor(isSelected ? color: .gray)
                HStack{
                    Spacer()
                    select_button(
                        isSelected: $isSelected, color: .blue, text: "Yes")
                        .onTapGesture {
                            isSelected.toggle()
                            if isSelected{
                                isSelected2 = false
                                firestoreManager.setRSVPyes(event_id: id)
                        }
                        
                        
                    }
                    select_button(
                        isSelected: $isSelected2, color: .red, text: "No")
                        .onTapGesture {
                            isSelected2.toggle()
                            if isSelected2{
                                isSelected = false
                                firestoreManager.setRSVPno(event_id: id)
                        }
                                
                        
                    }
                    Spacer()

                }
                
                Button("Submit"){
                    
                alertText = isSelected  ? "Thanks!" : "Thanks"
                showAlert.toggle()
            }.alert(alertText, isPresented: $showAlert){
                Button("Continue"){
                    
                }
            }
                
            
                
                Spacer()
                VStack{
                    List{
                        Section{
                            Text("Address")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                
                            Text("Event Address: \(event_address)")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                        }
                        Section{
                            Text("Date and Time")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                 
                            Text("the adress is ")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                        }
                        Section{
                            Text("Details")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    
                            Text("Event Description: \(event_description)")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                   
                            
                        }
                        
                    }
                   
                    
                   
                    
                    
                
                    
                }
            
                    
                }
                
            }
                        
        }
    }
            
        
//        VStack{
//
//
            

           
           
//            Text("Event Start Time:")
//            Text(inv_start_time, style: .date)
//            Text(inv_start_time, style: .time)
//            Text("Event End Time:")
//            Text(inv_end_time, style: .date)
//            Text(inv_end_time, style: .time)
            

//
//        }
//struct InvitationsDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        InvitationsDetailView()
//    }
//}

