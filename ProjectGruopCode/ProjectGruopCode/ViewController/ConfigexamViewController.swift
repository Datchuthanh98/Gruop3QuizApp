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
    var option = UserDefaults.standard.integer(forKey: "option")
    var timeDefaut = UserDefaults.standard.integer(forKey: "Time")
    var questionDefaut = UserDefaults.standard.integer(forKey: "NumbersQ")
    var id = ""
    var nameUser = ""
    var ref = Database.database().reference()
    @IBOutlet weak var inputTime: UITextField!
    @IBOutlet weak var inputQuestion: UITextField!
    @IBOutlet weak var btnCancelOutlet: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSave.layer.cornerRadius = btnSave.bounds.height / 2
        btnCancelOutlet.layer.cornerRadius = btnCancelOutlet.bounds.height / 2
        lblTime.layer.borderWidth = 1
        lblTime.layer.borderColor = #colorLiteral(red: 0.450210597, green: 0.4549507143, blue: 0.527284264, alpha: 1)
        lblTime.layer.masksToBounds = true
        lblQuestion.layer.borderWidth = 1
        lblQuestion.layer.borderColor = #colorLiteral(red: 0.450210597, green: 0.4549507143, blue: 0.527284264, alpha: 1)
        lblQuestion.layer.masksToBounds = true
        btnEdit.layer.cornerRadius = btnEdit.bounds.height / 2
        inputQuestion.layer.borderColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        inputQuestion.layer.borderWidth = 1
        inputTime.layer.borderColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        inputTime.layer.borderWidth = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTime.text = String(timeDefaut)
        lblTime.text = String(timeDefaut)
        inputQuestion.text = String(questionDefaut)
        lblQuestion.text = String(questionDefaut)
        
        inputQuestion.isHidden = true
        inputTime.isHidden = true
        btnSave.isHidden = true
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapOnScreen() {
        inputTime.resignFirstResponder()
        inputQuestion.resignFirstResponder()
    }
    
    @IBAction func clickSave(_ sender: Any) {
   
        
        if(inputQuestion.text == String(questionDefaut) && inputTime.text == String(timeDefaut)){
            print("do nothing")
        }else if (inputQuestion.text == "" || inputTime.text == "" ) {
            let alert = UIAlertController(title: "INVALID INPUT", message: "Required fields can not be blank! Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if (Int(inputTime.text!) ?? 0 > 90 || Int(inputTime.text!) ?? 0 <= 0) {
            let alert = UIAlertController(title: "INVALID INPUT", message: "Required fields time can  not over limit! Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if ( Int(inputQuestion.text!) ?? 0 > 20 || Int(inputQuestion.text!) ?? 0 <= 0 ) {
            let alert = UIAlertController(title: "INVALID INPUT", message: "Required fields  number question can  not over limit! Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
                 updateToFirebase()
            self.lblQuestion.text = self.inputQuestion.text
            self.lblTime.text  = self.inputTime.text
            inputTime.isHidden = true
            lblTime.isHidden = false
            inputQuestion.isHidden = true
            lblQuestion.isHidden = false
            let icon = UIImage(systemName: "doc.text.fill")
            btnSave.isHidden = true
        }
        
        
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
        
        
        let alertController = UIAlertController(title: "Update sucessfully", message: nil, preferredStyle: .alert)
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
