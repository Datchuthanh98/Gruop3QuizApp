//
//  ConfigexamViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/9/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class ConfigexamViewController: UIViewController {

    let option = UserDefaults.standard.integer(forKey: "Time")
    var timeDefaut = UserDefaults.standard.integer(forKey: "option")
    var questionDefaut = UserDefaults.standard.integer(forKey: "NumbersQ")
    var id = ""
    var nameUser = ""
    var ref = Database.database().reference()
    
    @IBOutlet weak var inputTime: UITextField!
    
    @IBOutlet weak var inputQuestion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTime.text = String(timeDefaut)
        inputQuestion.text = String(questionDefaut)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSave(_ sender: Any) {
        updateToFirebase()

    }
 
    
    @IBAction func btnCancel(_ sender: Any) {
                self.navigationController?.popViewController(animated: true)
    }
    
    func updateToFirebase(){
         let setting = [
            "time" : Int(self.inputTime.text!)! ,
            "question" : Int(self.inputQuestion.text!)!
                ] as [String : Any]
                
                ref.child("setting").child("1").setValue(setting,withCompletionBlock: { error , ref in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                  	
                    }
                } )
         
        

        UserDefaults.standard.set(Int(inputTime.text!)!, forKey: "Time")
        UserDefaults.standard.set(Int(inputQuestion.text!)!, forKey: "NumbersQ")
         print("update thanh cong")
     }
     
     func setProfile(){
         if(self.option == 1){
                   self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
               } else {
                   self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
               }
     }

}
