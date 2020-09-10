//
//  HistoryViewController.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UIPickerViewDelegate ,UIPickerViewDataSource, UITextFieldDelegate{
    
    
    
    var selectCategory = "Easy"
    var listCategory = [""]
    var STT = 1 ;
    var stageRank = 1
    var listRank = [1]
    
    
    
    var listHistory = [History(id: "", userName: "",avatar: "",  score: 1, numberQuestion:  1 ,timeComplete: 1,timeHistory: "")]
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
    var ref = Database.database().reference()
    
    
    
    @IBOutlet weak var inputCategory: UITextField!
    @IBOutlet weak var tblHistory: UITableView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCategory.text = selectCategory
        //        inputCategory.isUserInteractionEnabled = false
        createPickerView()
        dismissPickerView()
         self.inputCategory.delegate = self
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
      
        
        
        DispatchQueue.global().async {
             DispatchQueue.main.async {
                  cell.setRank(rank : indexPath.row+1)
                       cell.txtSTT.layer.cornerRadius = cell.txtScore.bounds.height / 2
                       cell.txtSTT.layer.masksToBounds = true
                       cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.bounds.height / 2
                 
                       cell.CardView.layer.cornerRadius = 8
                       cell.CardView.layer.masksToBounds = false
                       cell.CardView.layer.shadowOpacity = 0.8
                       cell.CardView.layer.shadowOffset = CGSize(width: 0, height: 1)
                       cell.CardView.layer.shadowColor = UIColor.black.cgColor
             }
         }
         
        
        
        
        cell.txtName.text = "Name : \(listHistory[indexPath.row].userName)"
        cell.txtScore.text = "Score : \(String(listHistory[indexPath.row].score))/ \(String(listHistory[indexPath.row].score))"
        cell.txtTimeHistory.text = "Create:  \(String(listHistory[indexPath.row].timeHistory))"
        cell.txtTimeDo.text = "Time :  \(String(listHistory[indexPath.row].timeComplete))"
        
        //set avatar
        var url = URL(string: self.listHistory[indexPath.row].avatar ?? "user")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.imgAvatar.image = UIImage(data: data!)
            }
        }
        
        
 
      
        
        
        
        //MARK
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
                let avatar = dict["avatar"] as! String
                let score = dict["score"] as! Int
                let timeComplete = dict["timeComplete"] as! Int
                let timeHistory = dict["timeHistory"] as! String
                let numberQuestion = dict["numberQuestion"] as! Int
                let h = History(id: idUser, userName: userName, avatar: avatar, score: score,numberQuestion: numberQuestion, timeComplete: timeComplete,timeHistory : timeHistory)
                self.listHistory.append(h)
                
            }
            self.listHistory = self.listHistory.sorted{
                a1, a2 in
                return (a1.score, a2.timeComplete) > (a2.score, a1.timeComplete)
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
    
    
}
