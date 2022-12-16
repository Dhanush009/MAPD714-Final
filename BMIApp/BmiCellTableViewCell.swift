//
//  BmiCellTableViewCell.swift
//  BMIApp
//
//  Created by Dhanush Sriram on 2022-12-16.
//

import UIKit

class BmiCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var weightAns: UILabel!
    
    @IBOutlet weak var bmiAns: UILabel!
    
    @IBOutlet weak var dateAns: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
