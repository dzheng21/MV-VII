//
//  ScheduleTableViewController.swift
//  Bells
//
//  Created by Carolyn DUan on 7/10/16.
//  Copyright © 2016 Carolyn Duan. All rights reserved.
//

import UIKit

    var scheduleTableContent: [[[String]]] = [
      [ // Mon
        ["Collabration", "7:45 - 8:35", "50m"],
        ["1st", "8:40 - 9:25", "45m"],
        ["2nd", "9:30 - 10:15", "45m"],
        ["3rd", "10:20 - 11:10", "50m"],
        ["Brunch", "11:10 - 11:25", "15m"],
        ["4th", "11:30 - 12:15", "45m"],
        ["5th", "12:20 - 1:05", "45m"],
        ["Lunch", "1:05 - 1:45", "40m"],
        ["6th", "1:50 - 2:35", "45m"],
        ["7th", "2:40 - 3:25", "45m"],
      ],
      [ // Tue
        ["1st", "8:00 - 8:45", "45m"],
        ["2nd", "8:50- 9:35", "45m"],
        ["Tutorial", "9:40 - 10:15", "35m"],
        ["3rd", "10:20 - 11:10", "50m"],
        ["Brunch", "11:10 - 11:25", "15m"],
        ["4th", "11:30 - 12:15", "45m"],
        ["5th", "12:20 - 1:05", "45m"],
        ["Lunch", "1:05 - 1:45", "40m"],
        ["6th", "1:50 - 2:35", "45m"],
        ["7th", "2:40 - 3:25", "45m"],
      ],
      [ // Wed
        ["Collaboration", "7:45 - 8:50", "65m"],
        ["4th", "8:55 - 10:30", "95m"],
        ["Tutorial", "10:35 - 11:15", "40m"],
        ["Brunch", "11:15 - 11:30", "15m"],
        ["5th", "11:35 - 1:05", "90m"],
        ["Lunch", "1:05 - 1:45", "40m"],
        ["6th", "1:50 - 3:20", "90m"],
        ],
      [ // Thur
        ["1st", "8:00 - 9:30", "90m"],
        ["2nd", "9:40 - 11:10", "90m"],
        ["Brunch", "11:10 - 11:25", "15m"],
        ["3rd", "11:30 - 1:05", "95m"],
        ["Lunch", "1:05 - 1:45", "40m"],
        ["7th", "1:50 - 3:20", "90m"],
        ],
      [ // Fri
        ["1st", "8:00 - 8:45", "45m"],
        ["2nd", "8:50- 9:35", "45m"],
        ["Tutorial", "9:40 - 10:15", "35m"],
        ["3rd", "10:20 - 11:10", "50m"],
        ["Brunch", "11:10 - 11:25", "15m"],
        ["4th", "11:30 - 12:15", "45m"],
        ["5th", "12:20 - 1:05", "45m"],
        ["Lunch", "1:05 - 1:45", "40m"],
        ["6th", "1:50 - 2:35", "45m"],
        ["7th", "2:40 - 3:25", "45m"],
      ],
]

class ScheduleTableViewController: UITableViewController {
	
	// var current: Int = -1
	var day = ScheduleHelper.getDayOfWeek()
    // var day = 5; // where forces day 3/3
	// var dataArray: [[String]]?

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
		self.tabBarController?.selectedIndex = 0
	}

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //     print("Day : ", day)
        
        if( (day<2) || (day>6) )    { return(0) }
        else                        { return(scheduleTableContent[day-2].count) }

    /*        switch day {
		case 3, 6: // tue, friday
			return 10
		case 5: // thurs
			return 6
		case 4: // wed
			return 7
		case 2: // mon
			return 10
		default: return 0
		}
 */
 
	}
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodTableViewCell
		
        cell.periodNum.text = scheduleTableContent[day-2][indexPath.row][0];
        cell.periodRange.text = scheduleTableContent[day-2][indexPath.row][1];
        cell.periodLength.text = scheduleTableContent[day-2][indexPath.row][2];
        
        /*
        switch indexPath.row {
        case 0:
            // first period
            switch(day) {
            case 2 : // mon
                cell.periodNum.text = "1st"
                cell.periodRange.text = "8:40 - 9:25"
                cell.periodLength.text = "45m"
            case 4: // wed
                cell.periodNum.text = "4th"
                cell.periodRange.text = "8:55 - 10:30"
                cell.periodLength.text = "1hr 35m"
            case 5: // thu
                cell.periodNum.text = "1st"
                cell.periodRange.text = "8:00 - 9:30"
                cell.periodLength.text = "1hr 30m"
            case 3, 6: // tuefri
                cell.periodNum.text = "1st"
                cell.periodRange.text = "8:00 - 8:45"
                cell.periodLength.text = "45m"
            default:
                print("will add later")
            }
            
        case 1: // 2nd pd
            switch(day) {
            case 2:
                cell.periodNum.text = "2nd"
                cell.periodRange.text = "9:30 - 10:15"
                cell.periodLength.text = "50m"
            case 4:
                cell.periodNum.text = "Tut"
                cell.periodRange.text = "10:35 - 11:15"
                cell.periodLength.text = "40m"
            case 5: // thu
                cell.periodNum.text = "2nd"
                cell.periodRange.text = "9:40 - 11:10"
                cell.periodLength.text = "1hr 30m"
            case 3, 6: // tuefri
                cell.periodNum.text = "2nd"
                cell.periodRange.text = "8:50 - 9:35"
                cell.periodLength.text = "45m"
            default:
                print("lmaooo")
            }
        case 2: // 3rd
            switch(day) {
            case 2:
                cell.periodNum.text = "3rd"
                cell.periodRange.text = "10:20 - 11:10"
                cell.periodLength.text = "50m"
            case 4:
                cell.periodNum.text = "Br"
                cell.periodRange.text = "11:15 - 11:30"
                cell.periodLength.text = "15m"
            case 5:
                cell.periodNum.text = "Br"
                cell.periodRange.text = "11:10 - 11:25"
                cell.periodLength.text = "15m"
            case 3, 6:
                cell.periodNum.text = "Tut"
                cell.periodRange.text = "9:40 - 10:15"
                cell.periodLength.text = "35m"
            default:
                print("lmao")
            }
        case 3: // 4th
            switch(day) {
            case 2:
                cell.periodNum.text = "Br"
                cell.periodRange.text = "11:10 - 11:25"
                cell.periodLength.text = "15m"
            case 4:
                cell.periodNum.text = "5th"
                cell.periodRange.text = "11:35 - 1:05"
                cell.periodLength.text = "1hr 30m"
            case 5:
                cell.periodNum.text = "3rd"
                cell.periodRange.text = "11:30 - 1:05"
                cell.periodLength.text = "1hr 35m"
            case 3, 6:
                cell.periodNum.text = "3rd"
                cell.periodRange.text = "10:20 - 11:10"
                cell.periodLength.text = "50m"
            default:
                print("lmao")
            }
        case 4: // 5th
            switch(day) {
            case 2:
                cell.periodNum.text = "4th"
                cell.periodRange.text = "11:30 - 12:15"
                cell.periodLength.text = "45m"
            case 4:
                cell.periodNum.text = "L"
                cell.periodRange.text = "1:05 - 1:45"
                cell.periodLength.text = "40m"
            case 5:
                cell.periodNum.text = "L"
                cell.periodRange.text = "1:05 - 1:45"
                cell.periodLength.text = "40m"
            case 3,6:
                cell.periodNum.text = "Br"
                cell.periodRange.text = "11:10 - 11:25"
                cell.periodLength.text = "15m"
            default:
                print("lmao")
            }
        case 5: // 6th
            switch(day) {
            case 2:
                cell.periodNum.text = "5th"
                cell.periodRange.text = "12:20 - 1:05"
                cell.periodLength.text = "45m"
            case 4:
                cell.periodNum.text = "6th"
                cell.periodRange.text = "1:50 - 3:20"
                cell.periodLength.text = "1hr 30m"
            case 5:
                cell.periodNum.text = "7th"
                cell.periodRange.text = "1:50 - 3:20"
                cell.periodLength.text = "1hr 30m"
            case 3, 6:
                cell.periodNum.text = "4th"
                cell.periodRange.text = "11:30 - 12:15"
                cell.periodLength.text = "45m"
            default: print("lmao")
            }
        case 6: // 7th
            switch(day) {
            case 2:
                cell.periodNum.text = "L"
                cell.periodRange.text = "1:05 - 1:45"
                cell.periodLength.text = "40m"
            case 3, 6:
                cell.periodNum.text = "5th"
                cell.periodRange.text = "12:20 - 1:05"
                cell.periodLength.text = "45m"
            default: print("wtf")
            }
        case 7: // 8th
            switch(day){
            case 2:
                cell.periodNum.text = "6th"
                cell.periodRange.text = "1:50 - 2:35"
                cell.periodLength.text = "45m"
            case 3, 6:
                cell.periodNum.text = "L"
                cell.periodRange.text = "1:05 - 1:45"
                cell.periodLength.text = "40m"
            default: print("lmao")
            }
        case 8: // 9th
            switch(day){
            case 2:
                cell.periodNum.text = "7th"
                cell.periodRange.text = "2:40 - 3:25"
                cell.periodLength.text = "45m"
            case 3, 6:
                cell.periodNum.text = "6th"
                cell.periodRange.text = "1:50 - 2:35"
                cell.periodLength.text = "45m"
            default: print("lmao")
            }
        case 9: // 10th
            switch(day) {
            case 2, 5:
                cell.periodNum.text = "7th"
                cell.periodRange.text = "2:40 - 3:25"
                cell.periodLength.text = "45m"
            default: print("omg done")
            }
        default:  print("IM DOOONE")
        }
        */
        return cell
	}
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
