//
//  EntryViewController.swift
//  LoginScreen
//
//  Created by Ankitha Kamath on 27/10/21.
//

import UIKit
import FirebaseFirestore
import Firebase


class EntryViewController: UIViewController{
    
    var noteArray = [NoteItem]()
    var isNew: Bool = true
    var note: NoteItem?
    
    
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    
    //public var completion:((String, String) -> Void)/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        newData()
    }
    
  
    
    func newData(){
        
        titleField.text = note?.title
        noteField.text = note?.description
        
    }
    
    func showAlert(title: String, message: String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let ok = UIAlertAction(title: "ok", style: .default) { (okClicked) in
           }
               alert.addAction(ok)
               self.present(alert, animated: true)
           }
    
    @objc func didTapSave(){
       
      
            if titleField.text == "" || noteField.text == "" {
                showAlert(title: "Notes", message: "Fields cannot be empty")
            }else if isNew{
                let newNote: [String: Any] = ["title": titleField.text, "note": noteField.text,"uid": NetworkManager.manager.getUID(),"time" : Date()]
                NetworkManager.manager.addNote(note: newNote)
                dismiss(animated: true, completion: nil)
                
                
            } else {
                note?.title = titleField.text!
                note?.description = noteField.text
                
                NetworkManager.manager.updateNote(note: note!)
               
            }
        navigationController?.popViewController(animated: true)
        }
        
    
   
}




