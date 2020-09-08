//
//  ExamTableViewCell.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/3/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit


protocol CategoryCellDelegate: AnyObject {
    func didTapButton(with title: String, cateid: Int)
}


class ExamTableViewCell: UITableViewCell {

    @IBOutlet weak var viewQuestion: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 50
        
    }
    @IBOutlet weak var viewExam: UIView!
    @IBOutlet weak var txtAnswer: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func checkChoose (){
//        
//    }
    
    
    
}
