//
//  EventTableViewCell.swift
//  Bells
//
//  Created by Carolyn DUan on 1/6/17.
//  Copyright © 2017 Carolyn Duan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
	
	@IBOutlet weak var eventColorView: UIView!
	@IBOutlet weak var descLabel: UILabel!
	@IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    //@IBOutlet weak var endLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
