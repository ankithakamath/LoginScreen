//
//  SettingsController.swift
//  SideMenu
//
//  Created by Ankitha Kamath on 27/10/21.
//



import UIKit

class SettingsController: UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI(){
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
}
