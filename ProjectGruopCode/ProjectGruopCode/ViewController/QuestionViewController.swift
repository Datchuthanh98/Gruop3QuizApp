

import UIKit
import Firebase

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {
    
    
    var category = ""
    var listQuestion = [Question(id: 1, question: "", answer1: "", answer2: "", answer3: "", answer4: "", right: 1)]
    var ref = Database.database().reference()
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"

    
    @IBOutlet weak var tblQuestion: UITableView!
    @IBOutlet weak var btnbacktohome: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        custom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Question"
 
        getData()
        tblQuestion.delegate = self
        tblQuestion.dataSource = self
        let nibName = UINib(nibName: "QuestionCustomCell", bundle: nil)
        tblQuestion.register(nibName, forCellReuseIdentifier: "QuestionCell")
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath ) as! QuestionCustomCell
        
        
        
        cell.txtQuestion.text = "Question \(indexPath.row + 1)"
        cell.txtContentQuestion.text = listQuestion[indexPath.row].question
        cell.txtA.text = "A. \(listQuestion[indexPath.row].answer1)"
        cell.txtB.text = "B. \(listQuestion[indexPath.row].answer2)"
        cell.txtC.text = "C. \(listQuestion[indexPath.row].answer3)"
        cell.txtD.text = "D. \(listQuestion[indexPath.row].answer4)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getData(){
        
        self.listQuestion.removeAll()
        print("cate la \(category) ")
        self.ref.child(self.dataTable).child(category).observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    print("Error")
                    return
                }
                let question = dict["Question"] as! String
                let answer1 = dict["Answer1"] as! String
                let answer2 = dict["Answer2"] as! String
                let answer3 = dict["Answer3"] as! String
                let answer4 = dict["Answer4"] as! String
                let right = dict["Right"] as! Int
                let id = dict["ID"] as! Int
                var q = Question(id: id, question: question, answer1: answer1, answer2: answer2, answer3: answer3, answer4: answer4, right: right)
                self.listQuestion.append(q)
            }
            self.tblQuestion.reloadData()
        }
    }
    
    func custom() {
        btnbacktohome.layer.cornerRadius = btnbacktohome.bounds.height / 2
    }
    

 
}
