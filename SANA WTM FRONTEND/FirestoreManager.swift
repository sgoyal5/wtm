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
    
    
    @Published var event_id: String = ""
    @Published var event_name: String = ""
    @Published var event_address: String = ""
    @Published var event_start_time: Date = Date()
    @Published var event_end_time: Date = Date()
    @Published var event_description: String = ""

    
    @Published var list = [MyEvents]()
    
    func fetchMyEvents() {

        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("tanvi_events").getDocuments() { (snapshot, error) in

            if error == nil {
                if let snapshot = snapshot {
                    //update list property in main thread, since it causes UI changes
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            return MyEvents(id: d.documentID,
                                event_name: d["event_name"] as? String ?? "",
                                event_address: d["event_address"] as? String ?? "",
                                event_start_time: (d["event_start_time"] as? Timestamp)?.dateValue() ?? Date(),
                                event_end_time: (d["event_end_time"] as? Timestamp)?.dateValue() ?? Date(),
                                event_description: d["event_description"] as? String ?? "")
                        }
                    }
                    }
                }
            }
    }
    
    func createEvent(event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String) {
        let db = Firestore.firestore()
        
        let newEvent = db.collection("users").document("tanvi_user").collection("tanvi_events").document()

        newEvent.setData(["id": newEvent.documentID, "event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description]) { error in
            //check for errors
        }
    }
    
//    @Published var updated_event_name: String = ""
//    @Published var updated_event_address: String = ""
//    @Published var updated_event_description: String = ""

//    working but all the fields need to be entered or else they are erased
    func updateEvent(event_id: String, event_name: String, event_address: String, event_description: String) {
        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("tanvi_events").document(event_id).updateData(["event_name": event_name, "event_address": event_address, "event_description": event_description])
    }
    

    func deleteEvent(event_id: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document("tanvi_user").collection("tanvi_events").document(event_id).delete()
    }
    
    init() {
        fetchUser()
        fetchMyEvents()
    }
}
