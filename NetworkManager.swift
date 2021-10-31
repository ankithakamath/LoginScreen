//
//  NetworkManager.swift
//  LoginScreen
//
//  Created by Ankitha Kamath on 28/10/21.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

struct NetworkManager {
    
    static let manager = NetworkManager()
    
    func signUp(withEmail email: String, password: String, completion:AuthDataResultCallback?){
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func login(withEmail email: String, password: String, completion:AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func signout() -> Bool{
        
        do {
            try Auth.auth().signOut()
            
        }catch{
            
        }
        return true
    }
    
  
    
    func getUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func deleteNote(note: NoteItem) {
           
           let db = Firestore.firestore()
           db.collection("notes").document(note.id).delete {
               error in
               
               if let error = error {
                   print(error.localizedDescription)
               }
           }
       }
   
    func getNotes( completion: @escaping([NoteItem]) -> Void) {
          
          let db = Firestore.firestore()
          db.collection("notes").whereField("uid", isEqualTo: NetworkManager.manager.getUID()).getDocuments() { snapshot, error in
              
              var noteItem = [NoteItem]()
              
              if let error = error {
                  
                  return
              }
              
              guard let snapshot = snapshot else {return}
              
              for document in snapshot.documents {
                  
                  let data = document.data()
                  let id = document.documentID
                  let title = data["title"] as? String ?? ""
                  let description = data["note"] as? String ?? ""
                  let uid = data["uid"] as? String ?? ""
                  let time = (data["time"] as? Timestamp)?.dateValue() ?? Date()
                  
                  let note = NoteItem(id: id, title: title, description: description, uid: uid, time: time)
                
                  noteItem.append(note)
                                 
              }
             
              completion(noteItem)
          }
          
      }
    
    func addNoteToFirebase(note: NoteItem, completion: @escaping(Error?) -> Void) {
            let db = Firestore.firestore()
            db.collection("notes").addDocument(data: note.dictionary)
    }
    
    func addNote(note: [String: Any]) {
           
           let db = Firestore.firestore()
           db.collection("notes").addDocument(data: note)
           
       }
    
    func updateNote(note: NoteItem) {
           
           let db = Firestore.firestore()
           db.collection("notes").document(note.id).updateData(["title": note.title, "note": note.description]) {
               error in
               
               if let error = error {
                   
                   print(error.localizedDescription)
               }
           }
           
       }
}
