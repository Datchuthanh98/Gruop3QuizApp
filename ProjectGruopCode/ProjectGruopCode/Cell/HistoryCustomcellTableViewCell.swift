//
//  HistoryCustomcellTableViewCell.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit

class HistoryCustomcellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtScore: UILabel!
    @IBOutlet weak var txtResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.view.layer.cornerRadius = 20
       
        
        // Initialization code
    }
    @IBOutlet weak var view: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
