//
//  edit profile.swift
//  account
//
//  Created by Sana Goyal on 7/4/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct MyVariables {
    static var event_id = ""
}

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
    @State private var showingSheet = false
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()
    
    @State private var image = UIImage()
    @State private var showSheet = false

    @EnvironmentObject var viewRouter: ViewRouter
    
    
    
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
                
                Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(50)
                        .padding(.all, 4)
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(8)
                
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
            
            Text("Change photo")
                    .font(.system(size: 15, weight: .bold))
                    .frame(width: 150)
                    .frame(height: 50)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
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
                                showingSheet.toggle()
//                                viewRouter.currentPage = .page5
                                MyVariables.event_id = item.id
//                                model.updateEvent(eventToUpdate: item)
                                
                            }){
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                            }.sheet(isPresented: $showingSheet) {
                                SheetView()
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

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var model = FirestoreManager()

    @EnvironmentObject var viewRouter: ViewRouter
    
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
            Spacer()
            Text("Manage your Event")
                .foregroundColor(.white)
                .bold()
            Spacer()
            Spacer()
            Spacer()
            HStack{
                Spacer()
        
                    Text("Event Details")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .padding().frame(alignment: .center)
                Spacer()
                
//                    Text("RSVPS")
//                    .foregroundColor(Color.white)
//                    .font(.headline)
//                    .padding()
                Spacer()
            }

                NavigationView{
                    Form{
                        Section{
                            TextField(("Event Name"), text: $eventname)
                            TextField("Address", text: $address)
                            TextField("Description", text: $description)

                            
                        }
                        
                        
                        Button(action: {
                            dismiss()
//                            viewRouter.currentPage = .page1
                            
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
//                            viewRouter.currentPage = .page1
                            dismiss()
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


struct profile_my_events_Previews: PreviewProvider {
    static var previews: some View {
        profile_my_events().environmentObject(ViewRouter())
    }
}
