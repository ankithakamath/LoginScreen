//
//  ProfileController.swift
//  SideMenu
//
//  Created by Ankitha Kamath on 27/10/21.
//

import UIKit

class ProfileController: UIViewController{
    
   
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
      
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
   
   
    
}
