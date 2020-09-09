

import UIKit
import Firebase

class ViewController: UIViewController ,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    
   

    @IBOutlet weak var loading: UIActivityIndicatorView!
    let contactCellId = "ExamTableViewCell"
    var stateListAnswer = ["1","2","3","4"]
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
    var  listQuestion: [Question] = []
    var ref = Database.database().reference()
    var category = ""
    var state = 0
    var timeTest = 30
    var score = 0
    var choose = -1
    var timer : Timer?
    var timerLoading : Timer?
  
  
    @IBOutlet weak var imgAnimate: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tblContact: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblStateQuestion: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    
    
    @IBOutlet weak var tblNamePlayer: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        custom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgAnimate.isHidden = true
        tblContact.delegate = self
            tblContact.dataSource = self
//        lblCategory.text = "The level exam : \(category)"
//        tblNamePlayer.text = "\(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
        DispatchQueue.main.async {
            self.getData()
        }
        runTimerGetData()
        tblContact.register(UINib.init(nibName: contactCellId, bundle: nil), forCellReuseIdentifier: contactCellId)
        tblContact.reloadData()
        self.tblContact.isScrollEnabled = false;
            }
    
    
    
    func nextQuestion(){
        state += 1
        lblStateQuestion.text = "\(state)/10"
        stateListAnswer.removeAll()
        stateListAnswer.append(listQuestion[state].answer1)
        stateListAnswer.append(listQuestion[state].answer2)
        stateListAnswer.append(listQuestion[state].answer3)
        stateListAnswer.append(listQuestion[state].answer4)
        lblQuestion.text = listQuestion[state].question
        tblContact.reloadData()
    }
    
    
  
    @IBAction func btnNext(_ sender: Any) {
        if(state < 10){
                 if(choose == listQuestion[state].right-1){
                    showCorrectAnimation()
                     score += 1 ;
                     lblScore.text = "Score : \(score)"
                     nextQuestion()
                 }else{
                    showIncorrectAnimation()
                     nextQuestion()
                 }
                 choose = -1
                 }else{
                  nextToResult()
             }
    }
    
    
    func getData(){
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
        }
    }
    
    
     func runTimer(){
               timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }
    
     func runTimerGetData(){
                  timerLoading = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkLoadData), userInfo: nil, repeats: true)
          }
    
       @objc func updateTimer(){
           timeTest -= 1
           lblTime.text = String(timeTest)
           if(timeTest == 0){
              nextToResult()
           }
       }
    
      @objc func checkLoadData(){
        if(self.listQuestion.count >= 10 ){
            timerLoading?.invalidate()
            loading.isHidden = true
            listQuestion.shuffled()
            runTimer()
            nextQuestion()
         }
    }
    func nextToResult(){
        timer?.invalidate()
     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "resultScreen") as! ResultViewController
        vc.score = self.score
        vc.category = self.category
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellId, for: indexPath) as!ExamTableViewCell
        cell.txtAnswer.text = stateListAnswer[indexPath.row]
        cell.txtAnswer.layer.borderWidth = 2
        cell.txtAnswer.layer.borderColor = UIColor.black.cgColor
        cell.txtAnswer.layer.cornerRadius = cell.txtAnswer.bounds.height / 2
        cell.txtAnswer.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        choose = indexPath.row
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    
         func custom() {

    }
    
    
    func showCorrectAnimation(){
        self.imgAnimate.image = UIImage.init(named: "correct")
        self.imgAnimate.isHidden = false
        let seconds = 0.25
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
           
                        self.imgAnimate.isHidden = true
        }
        
    }
    
    func showIncorrectAnimation(){
        self.imgAnimate.image = UIImage.init(named: "incorrect")
            self.imgAnimate.isHidden = false
            let seconds = 0.25
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
               
                            self.imgAnimate.isHidden = true
            }
    }
}


