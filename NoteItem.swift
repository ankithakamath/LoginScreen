//
//  note.swift
//  LoginScreen
//
//  Created by Ankitha Kamath on 28/10/21.
//

import Foundation
 import FirebaseFirestore

struct NoteItem {
    var id : String
    var title: String
    var description: String
    var uid: String
    var time: Date
    
    var dictionary: [String: Any] {
           return[
            "id": id,
           "title": title,
           "description": description,
           "uid":uid,
           "time":time
      
           ]
       }
}
