//
//  PeriodTableViewCell.swift
//  Bells
//
//  Created by Carolyn DUan on 7/11/16.
//  Copyright © 2016 Carolyn Duan. All rights reserved.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
	@IBOutlet weak var periodNum: UILabel!
	@IBOutlet weak var periodRange: UILabel!
	@IBOutlet weak var periodLength: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
