//
//  CountdownViewController.swift
//  Bells
//
//  Created by Carolyn DUan on 7/10/16.
//  Copyright © 2016 Carolyn Duan. All rights reserved.
//	TODO: FIX THING ABOUT HOW IT DOESN'T SHOW THE ONE HOUR THING.


import UIKit
import Alamofire
import SwiftyJSON

class CountdownViewController: UIViewController {
	
	fileprivate let apiKey = "AIzaSyA7O0BEo05XhiBnhxhR1ECr59ShhzkONsI"
	fileprivate let calendarId = "fuhsd.org_d3fc0uu9cn9t0g7qckkeg4cnok@group.calendar.google.com"

	@IBOutlet weak var countdownLabel: UILabel!
	@IBOutlet weak var contextLabel: UILabel!
	
	@IBOutlet weak var eventLabel1: UILabel!
	@IBOutlet weak var dateLabel1: UILabel!
	
	@IBOutlet weak var eventLabel2: UILabel!
	@IBOutlet weak var dateLabel2: UILabel!
	
	var eventArray: [Event] = []
	
	var day: Int = Count.day
    // var day: Int = 5;  // where forces day 2/3
    
	var timer: Timer?
	// var secondsLeft: Int = 0
	// var currentBlock: Int = 0 // a block of time — a period, brunch, lunch, passing pd. zero-indexed
	
	override func viewDidLoad() {
        super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(CountdownViewController.stopTimer), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(CountdownViewController.startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
		self.countdownLabel.text = "Loading..."
    
	//	performRequest()
		setupTimer()
    }
	
	/// Gets the two upcoming events.
	private func performRequest() {
		let timeMax: String = EventHelper.calculateMaxTime(months: 3) // 3 months from today.
		let timeMin: String = EventHelper.dateToRFC3339(date: Date())
		
		let params: Parameters = [
			"key": apiKey,
			"timeMax": timeMax,
			"timeMin": timeMin,
			"singleEvents": "true",
			"orderBy": "startTime",
			"maxResults": 20
		]
		
		let url = "https://www.googleapis.com/calendar/v3/calendars/\(calendarId)/events"
		
		Alamofire.request(url, parameters: params).validate().responseJSON { response in
			switch response.result {
			case .success:
				if let value = response.result.value {
					let json = JSON(value)
					let events = json["items"].arrayValue
					
					for eventJSON in events {
						if (EventHelper.eventIsRelevant(json: eventJSON)) {
							let event: Event = Event(json: eventJSON)
							self.eventArray.append(event)
						}
					}
					
					self.eventLabel1.text = self.eventArray[0].name
					self.dateLabel1.text = "\(EventHelper.formatEventDate(event: self.eventArray[0]))"
					
					self.eventLabel2.text = self.eventArray[1].name
					self.dateLabel2.text = "\(EventHelper.formatEventDate(event: self.eventArray[1]))"
					
					// get 1st event
					let currentEvent = self.eventArray[0]
					let desc = currentEvent.name
					let startDate = currentEvent.startDate
					let isItBreak = desc.range(of: "No Classes") != nil && Calendar.current.isDate(Date(), inSameDayAs: startDate)
					self.setupTimer(isItBreak)
				} else {
					print("uh oh something went wrong")
				}
			case .failure(let error):
				print("o no error")
				print(error)
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	@IBAction func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
		self.tabBarController?.selectedIndex = 1
	}
	
	// called when app is in background
	func stopTimer(_: Notification) {
		print("app in background")
		self.timer?.invalidate()
		self.timer = nil
		// in app delegate i record the time i guess
	}
	
	func startTimer(_: Notification) {
		print("is this called when app is first launched?")
		setupTimer()
	}
	
	/// Creates a timer if school is in session. if not, "School's out" text is displayed.
	// TODO: determine if school is on break (summer, holidays, etc)
	func setupTimer(_ isBreak: Bool = false)
	{
      //  print("Current block : ", Count.currentBlock)

		if (isBreak) {
			self.countdownLabel.isHidden = true
			self.contextLabel.text = "School's out!"
		} else {
			switch day {
			case 2, 3, 4, 5, 6: // change
	
				if Count.currentBlock < 0 {
					self.countdownLabel.isHidden = true
					self.contextLabel.text = "School's out!"
				} else {
					self.contextLabel.text = ScheduleHelper.getContextLabel(day, block: Count.currentBlock) //TODO: why -1? check for edge case
					timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(CountdownViewController.updateCountdown(_:)), userInfo: nil, repeats: true)
				}
                
			default: // if it's a weekend.
				self.countdownLabel.isHidden = true
				self.contextLabel.text = "School's out!"
			}
		}
	}
	
	/// called when timer fires.
	func updateCountdown(_ timer: Timer)
	{
        
  //      print("Current block2 : ", Count.currentBlock, "    day : ", day)

		if Count.secondsLeft > 0
		{
//			secondsLeft = ScheduleHelper.secondsLeftUntilNextBlock(self.day, currentHourMinSec: ScheduleHelper.getCurrentHMS()).1
//			print(secondsLeft)
			
			self.countdownLabel.textColor = Colors.colorArray[Count.currentBlock%5]
			
			let hr = Count.secondsLeft / 3600
			let min = (Count.secondsLeft % 3600) / 60
			let sec = (Count.secondsLeft % 3600) % 60
		//	if hr > 1 {  // BUG
            if hr > 0 {
				self.countdownLabel.text = "\(hr)hr \(min)m \(sec)s"
		//	} else if min > 1 { // BUG
            } else if min > 0 {
				self.countdownLabel.text = "\(min)m \(sec)s"
			} else {
				self.countdownLabel.text = "\(sec)s"
			}
		}
		else
		{
			Count.currentBlock = Count.currentBlock + 1
			
			if Count.currentBlock < ScheduleHelper.numBlocksInDay(day)
			{
				self.contextLabel.text = ScheduleHelper.getContextLabel(day, block: Count.currentBlock) // is -1 or not??
				
				// reset seconds left
                
				let tupletuple = ScheduleHelper.secondsLeftUntilNextBlock(day, currentHourMinSec: (
					(Calendar.current as NSCalendar).component(.hour, from: Date()),
					(Calendar.current as NSCalendar).component(.minute, from: Date()),
					(Calendar.current as NSCalendar).component(.second, from: Date())))
 
				Count.secondsLeft = tupletuple.1
			}
			else
			{ // stop timer
				self.timer?.invalidate()
				self.countdownLabel.text = "School's out!"
			}
		}
	}

}
