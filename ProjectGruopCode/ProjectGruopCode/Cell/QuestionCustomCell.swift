//
//  QuestionCustomCell.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/3/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit

class QuestionCustomCell: UITableViewCell {


    
    @IBOutlet weak var txtD: UILabel!
    @IBOutlet weak var txtC: UILabel!
    @IBOutlet weak var txtB: UILabel!
    @IBOutlet weak var txtA: UILabel!
    @IBOutlet weak var txtContentQuestion: UILabel!
    @IBOutlet weak var txtQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
