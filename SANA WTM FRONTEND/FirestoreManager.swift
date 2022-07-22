//
//  File.swift
//  test-wtm
//
//  Created by Tanvi Poondota on 7/16/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class FirestoreManager: ObservableObject {
        
    @Published var first_name: String = ""
    @Published var last_name: String = ""
    @Published var username: String = ""

    func fetchUser() {
        let db = Firestore.firestore()

        let docRef = db.collection("users").document("tanvi_user")

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.first_name = data["first_name"] as? String ?? ""
                    self.last_name = data["last_name"] as? String ?? ""
                    self.username = data["username"] as? String ?? ""
                }
            }
        }
    }
    
    
    @Published var id: String = ""
    @Published var event_name: String = ""
    @Published var event_address: String = ""
    @Published var event_start_time: Date = Date()
    @Published var event_end_time: Date = Date()
    @Published var event_description: String = ""


    
   // @Published var list = [MyEvents]()
    
//    func fetchMyEvents() {
//
//        let db = Firestore.firestore()
//
//        db.collection("users").document("tanvi_user").collection("tanvi_events").getDocuments() { (snapshot, error) in
//
//            if error == nil {
//                if let snapshot = snapshot {
//                    //update list property in main thread, since it causes UI changes
//                    DispatchQueue.main.async {
//                        self.list = snapshot.documents.map { d in
//                            return MyEvents(id: d.documentID,
//                                event_name: d["event_name"] as? String ?? "",
//                                event_address: d["event_address"] as? String ?? "",
//                                event_start_time: d["event_start_time"] as? Date ?? Date.now,
//                                event_end_time: d["event_end_time"] as? Date ?? Date.now,
//                                event_description: d["event_description"] as? String ?? "")
//                        }
//                    }
//                    }
//                }
//            }
//    }
//
//    @Published var updated_event_name: String = ""
//    @Published var updated_event_address: String = ""
//    @Published var updated_event_description: String = ""
    
//    func createEvent(event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String) {
//        let db = Firestore.firestore()
//
//        db.collection("users").document("tanvi_user").collection("tanvi_events").addDocument(data: ["event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description]) { error in
//            //check for errors
//        }
//    }
    
//    func editMyEvent(eventToUpdate: MyEvents) {
//        let db = Firestore.firestore()
    
    //let docref = db.collection("users").document("tanvi_user").collection("tanvi_events")
//
//        docRef.document(eventToUpdate.id).setData(["event_name": updated_event_name, "event_address": updated_event_address, "event_description": updated_event_description], merge: true) { error in
//
//            }
//        }
//
//    func updateRestaurant(restaurantName: String, restaurantAddress: String) {
//            let db = Firestore.firestore()
//
//            let docRef = db.collection("Restaurants").document(restaurantName)
//
//                    // Don't forget the **merge: true** before closing the parentheses!
//                    docRef.setData(["address": restaurantAddress], merge: true) ****{ error in
//                        if let error = error {
//                            print("Error writing document: \(error)")
//                        } else {
//                            print("Document successfully merged!")
//                        }
//                    }
//    }

    
    init() {
        fetchUser()
        //fetchMyEvents()
    }
}