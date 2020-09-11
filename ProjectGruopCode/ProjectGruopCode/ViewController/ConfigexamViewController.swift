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
    var isEdit = false
    var option = UserDefaults.standard.integer(forKey: "Time")
    var timeDefaut = UserDefaults.standard.integer(forKey: "option")
    var questionDefaut = UserDefaults.standard.integer(forKey: "NumbersQ")
    var id = ""
    var nameUser = ""
    var ref = Database.database().reference()
    @IBOutlet weak var inputTime: UITextField!
    @IBOutlet weak var inputQuestion: UITextField!
//    @IBOutlet weak var lblTime: UILabel!
//    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnCancelOutlet: UIButton!
//    @IBOutlet weak var btnSave: UIButton!
//    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    

    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSave.layer.cornerRadius = btnSave.bounds.height / 2
        btnCancelOutlet.layer.cornerRadius = btnCancelOutlet.bounds.height / 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTime.text = String(timeDefaut)
        inputQuestion.text = String(questionDefaut)
        lblQuestion.text = String(timeDefaut)
         lblTime.text = String(questionDefaut)
        inputQuestion.isHidden = true
        inputTime.isHidden = true
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.option = UserDefaults.standard.integer(forKey: "Time")
//        self.timeDefaut = UserDefaults.standard.integer(forKey: "option")
//        self.questionDefaut = UserDefaults.standard.integer(forKey: "NumbersQ")
//        inputTime.text = String(timeDefaut)
//        inputQuestion.text = String(questionDefaut)
//        lblQuestion.text = String(timeDefaut)
//         lblTime.text = String(questionDefaut)
//
//    }
    @objc func tapOnScreen() {
        inputTime.resignFirstResponder()
        inputQuestion.resignFirstResponder()
    }

    @IBAction func clickSave(_ sender: Any) {
                     updateToFirebase()
                self.lblQuestion.text = self.inputQuestion.text
                self.lblTime.text  = self.inputTime.text
                       inputTime.isHidden = true
                       lblTime.isHidden = false
                inputQuestion.isHidden = true
                lblQuestion.isHidden = false
                       let icon = UIImage(systemName: "doc.text.fill")
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
        let alertController = UIAlertController(title: "Update setting exam sucessfully", message: nil, preferredStyle: .alert)
           let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in}
            alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
     }
     func setProfile(){
         if(self.option == 1){
                   self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
               } else {
                   self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
               }
     }
    @IBAction func btnEdit(_ sender: Any) {
                if(isEdit == false){
                       lblTime.isHidden = true
                      lblQuestion.isHidden = true
                       inputTime.isHidden = false
                     inputQuestion.isHidden = false
                       let icon = UIImage(systemName: "doc.text")
                       btnEdit.setImage(icon, for: .normal)
                       btnSave.isHidden = false
                       isEdit == true
                   }
    }
}
