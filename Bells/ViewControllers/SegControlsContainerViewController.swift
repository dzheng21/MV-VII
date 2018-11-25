//
//  SegControlsContainerViewController.swift
//  Bells
//
//  Created by Carolyn DUan on 7/11/16.
//  Copyright © 2016 Carolyn Duan. All rights reserved.
//

import UIKit

class SegControlsContainerViewController: UIViewController {
	
	var tableView: UITableView?
	var tableVC: ScheduleTableViewController?
//	var day = ScheduleHelper.getDayOfWeek()
    var day = 2; // MON always
	@IBOutlet weak var dayOfWeekControl: UISegmentedControl!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		dayOfWeekControl.tintColor = Colors.colorArray[dayOfWeekControl.selectedSegmentIndex]
		
		let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!, forKey: NSFontAttributeName as NSCopying)
		self.dayOfWeekControl.setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	//	print("wait when does this appen")
		if segue.identifier == "selectDaySegue" {
			// TODO: set the selected segment control

			// showSelectedSchedule(self.dayOfWeekControl) // lmao??
			
			self.tableVC = segue.destination as? ScheduleTableViewController
			
			self.dayOfWeekControl.selectedSegmentIndex = (self.day < 7 && self.day > 1) ? (self.day - 2) : 0
			self.tableVC?.tableView.reloadData()
			
			showSelectedSchedule(self.dayOfWeekControl) // lmao??
		}
	}
	
	@IBAction func showSelectedSchedule(_ sender: UISegmentedControl) {
	//	print("ughh")
		
		sender.tintColor = Colors.colorArray[sender.selectedSegmentIndex]
		self.tableVC!.day = sender.selectedSegmentIndex + 2
		
		self.tableVC!.tableView.reloadData()
		self.tableVC!.tableView.tableFooterView = UIView()
		// self.tableView!.reloadData()
	}
	
}
