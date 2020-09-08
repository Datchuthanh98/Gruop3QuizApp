//
//  CategoryCustomCell.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit


protocol SmartDelegate: class {
    func didTapButton(with: String , nameCate : String)
}

class CategoryCustomCell: UITableViewCell {
    
    

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtCategory: UILabel!
    var nameCategory = "Easy"
    
    
    weak var delegate: SmartDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnClickSeeQuestion(_ sender: Any) {

        delegate?.didTapButton(with: "view", nameCate: self.nameCategory)
    }
    
    @IBAction func btnTryTest(_ sender: Any) {

        delegate?.didTapButton(with: "test", nameCate: self.nameCategory)
    }
}
