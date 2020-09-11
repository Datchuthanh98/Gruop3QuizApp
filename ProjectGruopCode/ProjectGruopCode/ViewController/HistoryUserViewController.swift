//
//  HistoryViewController.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class HistoryUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIPickerViewDelegate ,UIPickerViewDataSource, UITextFieldDelegate{
    
    
    var idUserLocal = UserDefaults.standard.string(forKey: "idGG") ?? ""
    var selectCategory = "Easy"
    var listCategory = [""]
    var STT = 1 ;
    var stageRank = 1
    var listRank = [1]
  
    
    
    var listHistory = [History(id: "", userName: "",avatar: "",  score: 1, numberQuestion:  1 ,timeComplete: 1,timeHistory: "")]
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
    var ref = Database.database().reference()
    
    
    
    @IBOutlet weak var tblHistory: UITableView!
    
    @IBOutlet weak var inputCategory: UITextField!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCategory.text = selectCategory
        self.inputCategory.delegate = self
        createPickerView()
        dismissPickerView()
        let nibName = UINib(nibName: "HistoryUserViewCell", bundle: nil)
        tblHistory.register(nibName, forCellReuseIdentifier: "HistoryUserCell")
        GetListCategory()
        getData()
        
        
        
    }
    
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputCategory.inputView = pickerView
        self.inputCategory.isUserInteractionEnabled = false
    }
    
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        var button = UIBarButtonItem(
            title: "OK",
            style: .plain,
            target: self,
            action: #selector(action(sender:))
        )
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.inputCategory.inputAccessoryView = toolBar
        self.inputCategory.isUserInteractionEnabled = true    }
    @objc func action(sender: UIBarButtonItem) {
        view.endEditing(true)
        getData()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.listCategory[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectCategory = self.listCategory[row]
        self.inputCategory.text =  self.selectCategory
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryUserCell", for: indexPath) as! HistoryUserViewCell
        
        cell.txtScore.text = "Score : \(String(listHistory[indexPath.row].score))/ \(String(listHistory[indexPath.row].score))"
       cell.txtTimeTest.text = "Create:  \(String(listHistory[indexPath.row].timeHistory))"
      cell.txtTimeComplete.text = "Time :  \(String(listHistory[indexPath.row].timeComplete))"
        

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func getData(){
        self.listHistory.removeAll()
        ref.child("history").child(self.selectCategory).observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    print("Error")
                    return
                }
                let idUser = dict["id"] as! String
                if(idUser == self.idUserLocal) {
                     let userName = dict["userName"] as! String
                                   let avatar = dict["avatar"] as! String
                                   let score = dict["score"] as! Int
                                   let timeComplete = dict["timeComplete"] as! Int
                                   let timeHistory = dict["timeHistory"] as! String
                                   let numberQuestion = dict["numberQuestion"] as! Int
                                   let h = History(id: idUser, userName: userName, avatar: avatar, score: score,numberQuestion: numberQuestion, timeComplete: timeComplete,timeHistory : timeHistory)
                                                                   self.listHistory.append(h)
                    
                }
               
                
            }
          
            
            self.tblHistory.reloadData()
        }
    }
    
    func GetListCategory(){
        self.listCategory.removeAll()
        ref.child(dataTable).observe(.value, with: {
            snapshot in
            for category in snapshot.children {
                self.listCategory.append((category as AnyObject).key)
            }
            
        })
    }
    @IBAction func btnBackk(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
    }
}
