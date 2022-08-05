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

    //fetches user to display profile information
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
    
    @Published var myeventslist = [Event]()
    
    @Published var event_id: String = ""
    @Published var event_name: String = ""
    @Published var event_address: String = ""
    @Published var event_start_time: Date = Date()
    @Published var event_end_time: Date = Date()
    @Published var event_description: String = ""
    @Published var bubbles_invited: [Any] = []
    
    
    //fetches events user has created
    func fetchMyEvents() {

        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("tanvi_events").getDocuments() { (snapshot, error) in

            if error == nil {
                if let snapshot = snapshot {
                    //update list property in main thread, since it causes UI changes
                    DispatchQueue.main.async {
                        self.myeventslist = snapshot.documents.map { d in
                            return Event(id: d.documentID,
                                event_name: d["event_name"] as? String ?? "",
                                event_address: d["event_address"] as? String ?? "",
                                event_start_time: (d["event_start_time"] as? Timestamp)?.dateValue() ?? Date(),
                                event_end_time: (d["event_end_time"] as? Timestamp)?.dateValue() ?? Date(),
                                event_description: d["event_description"] as? String ?? "",
                                bubbles_invited: d["bubbles_invited"] as? [String] ?? [])
                        }
                    }
                    }
                }
            }
    }
    
    //sends new event data to firestore, creates new document
    func createEvent(event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String, bubbles_invited: [String]) {
        
        let db = Firestore.firestore()
        print("\(bubbles_invited)")
        
        let newEvent = db.collection("users").document("tanvi_user").collection("tanvi_events").document()

        newEvent.setData(["id": newEvent.documentID, "event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description, "bubbles_invited": bubbles_invited]) { error in
            //check for errors
        }
        
        print(newEvent.documentID)
                        
        for bubble in bubbles_invited {
            db.collection("bubbles").document(bubble).collection("bubblies").getDocuments() { (snapshot , err) in
                    for document in snapshot!.documents {
                        let ref = document.reference
                        ref.collection("invitations").document("\(newEvent.documentID)").setData(["id": newEvent.documentID, "event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description]) { error in
                            //check for errors
                        }
                    }
                }

        }
        

        
    }
    
//    func sendInvites(event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String, bubbles_invited: [String]) {
//
//        let db = Firestore.firestore()
//
//        for bubble in bubbles_invited {
////        bubbles_invited.forEach(bubble) {
//        db.collection("bubbles").document(bubble).collection("bubblies").getDocuments() { (snapshot , err) in
//                for document in snapshot!.documents {
//                    let ref = document.reference
//                    ref.collection("invitations").document("\(newEvent.documentID)").setData(["id": newEvent.documentID, "event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description]) { error in
//                        //check for errors
//                    }
//                }
//            }
//
//    }
//    }
    
    
    //updates existing document in firestore
    func updateEvent(event_id: String, event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String) {
        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("tanvi_events").document(event_id).updateData(["event_name": event_name, "event_address": event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description])
    }
    

    //deletes document in firestore
    func deleteEvent(event_id: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document("tanvi_user").collection("tanvi_events").document(event_id).delete()
    }
    
    
    @Published var bubbleslist = [Bubbles]()
    
    @Published var bubble_id: String = ""
    @Published var bubble_name: String = ""
    @Published var isselected: Bool = false

    
    
    
    
    
    
    
    @Published var invitationslist = [Event]()
//
//    @Published var inv_id: String = ""
//    @Published var inv_name: String = ""
//    @Published var inv_address: String = ""
//    @Published var inv_start_time: Date = Date()
//    @Published var inv_end_time: Date = Date()
//    @Published var inv_description: String = ""
    
    
    //fetches events user has been invited to
    func fetchInvitations() {

        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("invitations").getDocuments() { (snapshot, error) in

            if error == nil {
                if let snapshot = snapshot {
                    //update list property in main thread, since it causes UI changes
                    DispatchQueue.main.async {
                        self.invitationslist = snapshot.documents.map { d in
                            return Event(id: d.documentID,
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
    
    
   
    func fetchMyBubbles() {

        let db = Firestore.firestore()

        db.collection("users").document("tanvi_user").collection("tanvi_bubbles").getDocuments() { (snapshot, error) in

            if error == nil {
                if let snapshot = snapshot {
                    //update list property in main thread, since it causes UI changes
                    DispatchQueue.main.async {
                        self.bubbleslist = snapshot.documents.map { d in
                            return Bubbles(id: d.documentID,
                                bubble_name: d["bubble_name"] as? String ?? "",
                                isselected: d["isselected"] as? Bool ?? false
                            ) }
                    }
                    }
                }
            }
    }
    
    func sendInvites(event_name: String, event_address: String, event_start_time: Date, event_end_time: Date, event_description: String, bubbles_invited: [String]) {

        let db = Firestore.firestore().collection("bubbles")
        
        for bubble in bubbles_invited {
            db.document(bubble).collection("bubblies").getDocuments() { snapshot , err in
                    for document in snapshot!.documents {
                        let ref = document.reference
                        let invite = ref.collection("invitations").document()
                        invite.setData(["id": invite.documentID, "event_name" : event_name, "event_address" : event_address, "event_start_time": event_start_time, "event_end_time": event_end_time, "event_description": event_description])
                    }
                }
        }
                                        }
                                        
        
//        db.collection("bubbles").whereField("bubble_id", isEqualTo: bubble_id)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        return document.reference.path
//                    }
//                }
//        }
    
    func setRSVPyes(event_id: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document("tanvi_user").collection("invitations").document(event_id).updateData(["responded": true, "rsvp": "yes"])
        
        
        
    }
    
    func setRSVPno(event_id: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document("tanvi_user").collection("invitations").document(event_id).updateData(["responded": true, "rsvp": "no"])
        
    }
    
    init() {
        fetchUser()
        fetchMyEvents()
        fetchInvitations()
        fetchMyBubbles()
    }
}
