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
    var isEdit = false
    let option = UserDefaults.standard.integer(forKey: "option")
    var nameUser = "\(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
    var imgAvatar = "\(UserDefaults.standard.string(forKey: "avatar") ?? "Underfined")"
    var id = ""
    var ref = Database.database().reference()
    @IBOutlet weak var inputName: UITextField!
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var btnEdit: UIButton!

    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSave: UIButton!

    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnCancelOutlet: UIButton!
    @IBOutlet weak var btnSaveOutlet: UIButton!
//    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewAvatar.layer.cornerRadius = viewAvatar.bounds.height / 2
        btnLogout.layer.cornerRadius = btnLogout.bounds.height / 2
        btnCancelOutlet.layer.cornerRadius = btnCancelOutlet.bounds.height / 2
        btnSaveOutlet.layer.cornerRadius = btnSaveOutlet.bounds.height / 2
        btnEdit.layer.cornerRadius = btnEdit.bounds.height / 2
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.isHidden = true
        inputName.text = nameUser
        lblName.text = nameUser
        btnSave.isHidden = true
        setProfile()
        setAvatar()

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func tapOnScreen() {
        inputName.resignFirstResponder()
    }



    
    @IBOutlet weak var viewAvatar: UIImageView!
    @IBAction func btnSave(_ sender: Any) {
        if(inputName.text == nameUser){
            print("khong thay doi")
            }else {
            updateToFirebase()
            }
        self.nameUser = inputName.text ?? self.nameUser
        lblName.text = inputName.text
        inputName.isHidden = true
        lblName.isHidden = false
        let icon = UIImage(systemName: "doc.text.fill")
        btnSave.isHidden = true
        btnLogout.isHidden = false
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func updateToFirebase(){
        if self.inputName.text == "" {
               let alert = UIAlertController(title: "Input error", message: "Required fields can not be blank! Please try again.", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           } else {
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
                     let alertController = UIAlertController(title: "Update sucessfully", message: nil, preferredStyle: .alert)
               self.present(alertController, animated: true, completion: nil)
           }
    }
    
 
    
    
    func setProfile(){
        if(self.option == 1){
                  self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
              } else {
                  self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
              }
    }

    

    
    @IBAction func signOut(_ sender: Any) {
        showAlertSignout()
    }
    func setAvatar(){
        let url = URL(string: self.imgAvatar)
              DispatchQueue.global().async {
                  let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                  DispatchQueue.main.async {
                    print("vao day r")
                    self.viewAvatar.image = UIImage(data: data!)
                  }
              }
    }
    func showAlertSignout() {
         let alertController = UIAlertController(title: "Do you want exit", message: nil, preferredStyle: .alert)
         let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    UserDefaults.standard.removeObject(forKey: "option")
                             UserDefaults.standard.removeObject(forKey: "nameUserSession")
                               UserDefaults.standard.removeObject(forKey: "idGG")
                             UserDefaults.standard.removeObject(forKey: "idFB")
                             let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
                             self.navigationController?.pushViewController(vc, animated: true)
         }
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("cancel")
        }
         alertController.addAction(confirmAction)
         alertController.addAction(cancelAction)
         self.present(alertController, animated: true, completion: nil)
     }
    @IBAction func btnEditProfile(_ sender: Any) {
               if(isEdit == false){
                   lblName.isHidden = true
                   inputName.isHidden = false
                   let icon = UIImage(systemName: "doc.text")
                   btnEdit.setImage(icon, for: .normal)
                   btnSave.isHidden = false
                   isEdit == true
                btnLogout.isHidden = true
           }
    }
    
    
    func checkOut(){
  
   
    }
}
