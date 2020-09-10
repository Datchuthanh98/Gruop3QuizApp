//
//  ProfileViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/9/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    let option = UserDefaults.standard.integer(forKey: "option")
    var nameUser = "\(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
    var id = ""
    var ref = Database.database().reference()
    @IBOutlet weak var inputName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.text = nameUser
        setProfile()
    }
    

    @IBAction func btnSave(_ sender: Any) {
        
        if(inputName.text == nameUser){
            print("khong thay doi")
            }else {
            updateToFirebase()
            }
        
        
//          self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateToFirebase(){
        let profile = [
            "name" : inputName.text,
               ] as [String : Any]
               
               ref.child("profile").child(id).setValue(profile,withCompletionBlock: { error , ref in
                   if error == nil {
                       self.dismiss(animated: true, completion: nil)
                   }else{
                       //handle
                   }
               } )
        
        UserDefaults.standard.set(inputName.text, forKey: "nameUserSession")
        print("update thanh cong")
    }
    
    func setProfile(){
        if(self.option == 1){
                  self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
              } else {
                  self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
              }
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "option")
                         UserDefaults.standard.removeObject(forKey: "nameUserSession")
                           UserDefaults.standard.removeObject(forKey: "idGG")
                         UserDefaults.standard.removeObject(forKey: "idFB")
                         let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
                         self.navigationController?.pushViewController(vc, animated: true)
    }
}
