//
//  HistoryViewController.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIPickerViewDelegate ,UIPickerViewDataSource{
   
    
    
    var selectCategory = "Easy"
    var listCategory = [""]
    
    
    
    @IBOutlet weak var btnBacktoHome: UIButton!
    var listHistory = [History(id: "", userName: "",  score: 1, isPassed: "PASS")]
     let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
     var ref = Database.database().reference()
 


    @IBOutlet weak var inputCategory: UITextField!
    @IBOutlet weak var tblHistory: UITableView!
    
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        custom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCategory.text = selectCategory
//        inputCategory.isUserInteractionEnabled = false
        createPickerView()
        dismissPickerView()
        let nibName = UINib(nibName: "HistoryCustomcellTableViewCell", bundle: nil)
        tblHistory.register(nibName, forCellReuseIdentifier: "HistoryCell")
        GetListCategory()
        getData()
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputCategory.inputView = pickerView
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
      }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCustomcellTableViewCell
        cell.txtName.text = "Name : \(listHistory[indexPath.row].userName)"
        cell.txtScore.text = "Score : \(String(listHistory[indexPath.row].score))/10"
        cell.txtCategory.text = "Id : \(listHistory[indexPath.row].id)"
        if(listHistory[indexPath.row].isPassed == "FAIL" ){
            cell.txtResult.textColor = UIColor.red
            cell.txtResult.text = "FAIL"
            
        }
        else if (listHistory[indexPath.row].isPassed == "PASS"){
            cell.txtResult.textColor = UIColor.green
            cell.txtResult.text = "PASS"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
                  let userName = dict["userName"] as! String
                  let score = dict["score"] as! Int
                  let isPassed = dict["isPassed"] as! String
        
                  
                 
                let h = History(id: idUser, userName: userName, score: score, isPassed: isPassed)
                  self.listHistory.append(h)
            
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
    
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func custom() {
        btnBacktoHome.layer.cornerRadius = btnBacktoHome.bounds.height / 2
    }

}
