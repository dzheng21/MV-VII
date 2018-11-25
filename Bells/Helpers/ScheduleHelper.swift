//
//  ScheduleHelper.swift
//  Bells
//
//  Created by Carolyn DUan on 7/10/16.
//  Copyright © 2016 Carolyn Duan. All rights reserved.
//

import Foundation

var blocksInDay: [[Int]] = [
    [ // Mon
        50, 5, 45, 5, 45, 5, 50, 15, 5, 45, 5, 45, 40, 5, 45, 5, 45
    ],
    [ // Tue
        45, 5, 45, 5, 35, 5, 50, 15, 5, 45, 5, 45, 40, 5, 45, 5, 45
    ],
    [ // Wed
        65, 5, 95, 5, 40, 15, 5, 90, 40, 5, 90
    ],
    [ // Thurs
        90, 10, 90, 15, 5, 95, 40, 5, 90
    ],
    [ // Fri
        45, 5, 45, 5, 35, 5, 50, 15, 5, 45, 5, 45, 40, 5, 45, 5, 45
    ]
]

var startSecondsArray: [Int] = [ 7*3600+45*60, 8*3600, 7*3600+45*60, 8*3600, 8*3600 ]

var dayContext: [[String]] = [
    [ // Mon
        "Collaboration period starts at 7:45 in",
        "Collaboration period ends at 8:35 in",
        "1st period starts at 8:40 in", // 1
        "1st period ends at 9:25 in",
        "2nd period starts at 9:30 in",
        "2nd period ends at 10:15 in",
        "3rd period starts at 10:20 in", //4
        "3rd period ends and brunch starts at 11:10 in",
        "Brunch ends at 11:25 in",
        "4th period starts at 11:30 in", // 7
        "4th period ends at 12:15 in",
        "5th period starts at 11:20 in", // 9
        "5th period ends and lunch starts at 1:05 in",
        "Lunch ends at 1:45 in",
        "6th period starts at 1:50 in", // 12
        "6th period ends at 2:35 in",
        "7th period starts at 2:40 in", // 14
        "7th period and school ends at 3:25 in"
    ],
    [ // Tue
        "1st period starts at 8:00 in",
        "1st period ends at 8:45 in",
        "2nd period starts at 8:50 in",
        "2nd period ends at 9:35 in",
        "Tutorial period starts at 9:40 in", // 1
        "Tutorial period ends at 10:15 in",
        "3rd period starts at 10:20 in", //4
        "3rd period ends and brunch starts at 11:10 in", //4
        "Brunch ends at 11:25 in",
        "4th period starts at 11:30 in", // 7
        "4th period ends at 12:15 in",
        "5th period starts at 11:20 in", // 9
        "5th period ends and lunch starts at 1:05 in",
        "Lunch ends at 1:45 in",
        "6th period starts at 1:50 in", // 12
        "6th period ends at 2:35 in",
        "7th period starts at 2:40 in", // 14
        "7th period and School ends at 3:25 in"
    ],
    [ // Wed
        "Collaboration period starts at 7:45 in",
        "Collaboration period ends at 8:35 in",
        "4th period starts at 8:55 in", // 1
        "4th period ends at 10:30 in",
        "Tutorial period starts at 10:35 in", // 1
        "Tutorial period ends and brunch starts at 11:15 in",
        "Brunch ends at 11:30 in",
        "5th period starts at 11:35 in", // 1
        "5th period ends and lunch starts at 1:05 in", // 1
        "Lunch ends at 1:45 in",
        "6th period starts at 1:50 in", // 4
        "6th period and school end at 3:20 in"
    ],
    [ // Thur
        "1st period starts at 8:00 in",
        "1st period ends at 9:30 in",
        "2nd period starts at 9:40 in", // 1
        "2nd period ends and brunch starts at 11:10 in", // 1
        "Brunch ends at 11:25 in",
        "3th period starts at 11:30 in", // 7
        "3th period ends and lunch starts at 1:05 in",
        "Lunch ends at 1:45 in",
        "7th period starts at 1:50 in", // 14
        "7th period and school end at 3:20 in"
    ],
    [ // Fri
        "1st period starts at 8:00 in",
        "1st period ends at 8:45 in",
        "2nd period starts at 8:50 in",
        "2nd period ends at 9:35 in",
        "Tutorial period starts at 9:40 in", // 1
        "Tutorial period ends at 10:15 in",
        "3rd period starts at 10:20 in", //4
        "3rd period ends and brunch starts at 11:10 in", //4
        "Brunch ends at 11:25 in",
        "4th period starts at 11:30 in", // 7
        "4th period ends at 12:15 in",
        "5th period starts at 11:20 in", // 9
        "5th period ends and lunch starts at 1:05 in",
        "Lunch ends at 1:45 in",
        "6th period starts at 1:50 in", // 12
        "6th period ends at 2:35 in",
        "7th period starts at 2:40 in", // 14
        "7th period and school ends at 3:25 in"
    ]
]

class ScheduleHelper {
    
	static func getDayOfWeek(date: Date = Date()) -> Int {
		let dateComponents: DateComponents = (Calendar.current as NSCalendar).components([NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year], from: date)
		let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
		if let date = gregorianCalendar.date(from: dateComponents) {
			return (gregorianCalendar as NSCalendar).component(.weekday, from: date)
		} else {
			return -1
		}
	}
	
	static func numBlocksInDay(_ day: Int) -> Int{
        
        if(day<2) { return(0) }
        else      { return(blocksInDay[day-2].count) }
        
        /*
		switch day {
		case 6: // fri
			return fri.count //monFri.count
		case 3: // tues
			return tues.count
		case 4: // wed
			return wed.count
		case 2, 5: // mon thurs tutorial
			return monThurs.count
		default:
			return 0
		}
        */
	}
	
	static func getContextLabel(_ day: Int, block: Int) -> String {
		// make this stuff an attributed string later ...
                
        if((day<2) || (day>6)) {
            return "School's out!!!!!"
        } else {
            return(dayContext[day-2][block])
        }
        
        /*
		switch day {
		case 6:
			// check if block is negative (right before school starts?)
			return friContext[block]
		case 3:
			return tuesContext[block]
		case 4:
			return wedContext[block]
		case 2, 5:
			return monThursContext[block]
		default:
			return "School's out!!!!!"
		}
 */
	}
	
	/// return: (index of next block, seconds left)
	static func secondsLeftUntilNextBlock(_ day: Int, currentHourMinSec: (Int, Int, Int)) -> (Int, Int) {
		
        // get currentSeconds (from 12:00 AM) using current hour min sec
		let currentSeconds = currentHourMinSec.0*3600 + currentHourMinSec.1*60 + currentHourMinSec.2
        
        if((day<2) || (day>6)) {
           // print("weekends")
            return (-1, -1)
        } else {
            let startSeconds = startSecondsArray[day-2]
            return findIndexAndSecsLeft(blocksInDay[day-2], start: startSeconds, currentSec: currentSeconds)
        }

        /*
		switch day {
		case 6:
			let startSeconds = 7*3600 + 35*60
			return findIndexAndSecsLeft(fri, start: startSeconds, currentSec: currentSeconds)
		case 3:
			let startSeconds = 7*3600 + 35*60
			return findIndexAndSecsLeft(tues, start: startSeconds, currentSec: currentSeconds)
		case 4:
			let startSeconds = 9*3600 + 25*60
			return findIndexAndSecsLeft(wed, start: startSeconds, currentSec: currentSeconds)
		case 2, 5:
			let startSeconds = 7*3600 + 35*60
			return findIndexAndSecsLeft(monThurs, start: startSeconds, currentSec: currentSeconds)
		default:
			print("this should only print on weekends")
			return (-1, -1)
		}
        */
	}
	
	static func getCurrentHMS() -> (Int, Int, Int) {
		return ((Calendar.current as NSCalendar).component(.hour, from: Date()),
		        (Calendar.current as NSCalendar).component(.minute, from: Date()),
		        (Calendar.current as NSCalendar).component(.second, from: Date()))
     //   return ( 16, 55, 12 )  // Where forcing time 1/1
	}
	
	static fileprivate func findIndexAndSecsLeft(_ array: [Int], start: Int, currentSec: Int) -> (Int, Int) {
		var wtflet = start
		
		if wtflet-(60*30)..<wtflet ~= currentSec {
			// 30 minutes before..
			print("within 30 min before school starts")
			return (0, wtflet - currentSec)
		}
		if currentSec < wtflet {
		//	print("current sec: \(currentSec), school start sec: \(wtflet)") // idea: just add a 30 min thing to the beginning of each thing
			return (-1, -1)
		}
		for (index, min) in array.enumerated() {
			wtflet += min*60
			if currentSec < wtflet {
				// current block = index!!
           //     if (index == array.count - 1) { // last index // BUG!!!!!!
				if (index == array.count) { // last index
					return (-1, wtflet - currentSec)
				}
				return (index + 1, wtflet - currentSec)
			}
		}
	//	print("ohhhhh")
		return (-2, -1) ///////////////////////////////////////////// FIIIIXXXXXX
	}
	
	
	// MARK: min-for-block arrays
      /*
	static var fri: [Int] = [50, 5, 50, 5, 50, 15, 5, 50, 5, 55, 45, 5, 50, 5, 50]
	// 0: first pd (ends in)
	// 1: first-second passing
	// 2: sec pd (ends in)
	// 3: sec-third passing
	// 4: third pd (ends in) OR brunch starts in
	// 5: brunch ends in
	// 6: 4th starts in (passing)
	// 7: 4th (ends in)
	// 8: 4th-5th passing
	// 9: 5th (ends in) OR lunch starts in
	// 10: lunch ends in
	// 11: passing lunch-6th
	// 12: 6th (ends in)
	// 13: 6th-7th passing
	// 14: 7th (ends in)
	
	static var tues: [Int] = [95, 5, 95, 15, 5, 95, 45, 5, 95]
    static var wed: [Int] = [95, 5, 95, 45, 5, 95]

	static var monThurs: [Int] = [45, 5, 45, 35, 5, 45, 15, 5, 45, 5, 50, 45, 5, 45, 5, 45]
	
	static var friContext: [String] = [
		"1st period ends at 8:25 in",
		"2nd period starts at 8:30 in", // 1
		"2nd period ends at 9:20 in",
		"3rd period starts at 9:25 in", // 4
		"3rd period ends at at 10:15 in",
		"Brunch ends at 10:30 in",
		"4th period starts at 10:35 in", // 6
		"4th period ends at 11:25 in",
		"5th period starts at 11:30 in", // 8
		"Lunch starts at 12:25 in",
		"Lunch ends at 1:10 in",
		"6th period starts at 1:15 in", // 11 
		"6th period ends at 2:05 in",
		"7th period starts at 2:10 in", // 13
		"School ends at 3:00 in"
	]
	
	static var tuesContext: [String] = [
		"1st period ends at 9:10 in",
		"3rd period starts at 9:15 in", // 1
		"3rd period ends at 10:50 in",
		"Brunch ends at 11:05 in",
		"5th period starts at 11:10 in", // 4
		"Lunch starts at 12:45 in",
		"Lunch ends at 1:30 in",
		"7th period starts at 1:35 in", // 7
		"School ends at 3:10 in"
	]
	static var wedContext: [String] = [
		"2nd period ends at 11:00 in",
		"4th period starts at 11:05 in", // 1
		"Lunch starts at 12:40 in",
		"Lunch ends at 1:25 in",
		"6th period starts at 1:30 in", // 4
		"School ends at 3:05 in"
	]
	
	static var monThursContext: [String] = [
		"1st period ends at 8:20 in",
		"2nd period starts at 8:25 in", // 1
		"Tutorial starts at 9:10 in",
		"Tutorial ends at 9:45 in",
		"3rd period starts at 9:50 in", //4
		"3rd period ends at 10:35 in",
		"Brunch ends at 10:50 in",
		"4th period starts at 10:55 in", // 7
		"4th period ends at 11:40 in",
		"5th period starts at 11:45 in", // 9
		"Lunch starts at 12:35 in",
		"Lunch ends at 1:20 in",
		"6th period starts at 1:25 in", // 12
		"6th period ends at 2:10 in",
		"7th period starts at 2:15 in", // 14
		"School ends at 3:00 in" 
	]
 
 */
	
}
