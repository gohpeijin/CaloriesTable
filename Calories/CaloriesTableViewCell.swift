//
//  CaloriesTableViewCell.swift
//  Calories
//
//  Created by gohpeijin on 06/08/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class CaloriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var labelFoodName: UILabel!
    @IBOutlet weak var labelFoodCalories: UILabel!
    
    static let identifier = "CaloriesTableViewCell" // for register the cell

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // for register the cell
    static func nib() -> UINib {
        return UINib(nibName: "CaloriesTableViewCell", bundle: nil)
    }
}
