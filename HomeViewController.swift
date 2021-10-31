//
//  HomeViewController.swift
//  LoginScreen
//
//  Created by Ankitha Kamath on 20/10/21.
//

import UIKit
import GoogleSignIn
import FirebaseAuth


class HomeViewController: UIViewController{
    
    var note: NoteItem?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    //var noteList: [NoteItem] = []
    //    var width: CGFloat = 0
    var noteArray :[NoteItem] = []
    
    var delegate: HomecControllerDelegate?
    
    func homeView(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        
    }
    
    func fetchData() {
        
        NetworkManager.manager.getNotes { noteItem in
            self.noteArray = noteItem
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    
    
    
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
        
    }
    
    @objc func handleAddNote(){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addscreen = storyboard.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        addscreen.isNew = true
        navigationController?.pushViewController(addscreen, animated: true)
        
    }
    
    
    
    func checkUserAlreadyLoggedIn(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if user == nil {
                DispatchQueue.main.async {
                    self.presentLoginScreen()
                }
            }
        }
    }
    
    func presentLoginScreen(){
        print("----------")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    func configureNavigationBar(){
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .red
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "note")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddNote))
    }
    
    @objc func handleDelete(_ sender: UIButton){
        let note = noteArray[sender.tag]
        NetworkManager.manager.deleteNote(note: note)
        noteArray.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func getCurrentDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
        
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return noteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addscreen = storyboard.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        addscreen.isNew = false
        addscreen.note = noteArray[indexPath.row]
        navigationController?.pushViewController(addscreen, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let note = noteArray[indexPath.row]
        cell.title.text = note.title
        cell.noteDescription.text = note.description
        cell.dateLabel.text = getCurrentDate(date: note.time)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        //        cell.title.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        //
        return cell
        
    }
    
}



extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = UIScreen.main.bounds.width
        return CGSize(width: collectionWidth/2  , height: collectionWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


/*func didTapNewNote(){
 
 let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
 guard let vc = storyboard.instantiateViewController(withIdentifier: "new") as? EntryViewController else{
 return
 }
 vc.title = "New Note"
 vc.navigationItem.largeTitleDisplayMode = .never
 //vc.completion = { noteTitle, note in
 self.models.append((title:"noteTitle", note: "note"))
 self.table.reloadData()
 navigationController?.pushViewController(vc, animated: true)
 }*/
