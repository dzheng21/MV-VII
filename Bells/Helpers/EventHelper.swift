//
//  EventHelper.swift
//  Bells
//
//  Created by Carolyn DUan on 1/7/17.
//  Copyright © 2017 Carolyn Duan. All rights reserved.
// TODO: ugh the dates are off for some reason

import Foundation
import SwiftyJSON

class EventHelper {
		
	static func shortToDate(timestamp: String) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: timestamp)!
	}
	
	static func dateToRFC3339(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T00:00:00-08:00" // TODO: idk when i would use this besides timeMin
		// print(formatter.string(from: date as Date))
		return formatter.string(from: date as Date)
	}
	
	static func eventIsRelevant(json: JSON) -> Bool {
		let name = json["summary"].stringValue
		return (name.range(of: "@") == nil && name.range(of: "vs.") == nil && name.range(of: "Senior All Night Party") == nil) ? true : false
	}
	
	static func rfc3339ToDate(timestamp: String) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		
		let start = timestamp.index(timestamp.startIndex, offsetBy: 19)
		return formatter.date(from: timestamp.substring(to: start))!
	}
	
	
	/** 
	 Adds x months to the current date and returns the value as a RFC3339 timestamp.
	 @param months
		The number of months to add to the current date.
	*/
	static func calculateMaxTime(months: Int) -> String {
		let ddd = Calendar.current.date(byAdding: .month, value: months, to: Date())
		return dateToRFC3339(date: ddd!)
	}
	
	// Friday, Jan. 13th
	static func formatDateShort(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "E, MMM d 'at' HH:mm a"
		return formatter.string(from: date)
	}
	
	// for use on countdownEventController
	static func formatEventDate(event: Event) -> String {
		let formatter = DateFormatter()
		let startDate = event.startDate
		let endDate = event.endDate
		if (event.fullDay) {
			// TODO: 1 day holiday. Mon, Jan 1st
			if (daysBetweenDates(startDate: startDate, endDate: endDate) == 1) {
				formatter.dateFormat = "E, MMM d"
				return formatter.string(from: startDate)
			} else {
				// multiple days. assume break: Mon, Jan 1st to Fri, Jan 7th
				formatter.dateFormat = "E, MMM d"
				return "\(formatter.string(from: startDate)) to \(formatter.string(from: endDate))"
			}
		} else {
			formatter.dateFormat = "E, MMM d 'from' h:mm a"
			//let firstString = formatter.string(from: startDate)
			let second = DateFormatter()
			second.dateFormat = " 'to' h:mm a"
			return formatter.string(from: startDate) + second.string(from: endDate)
		}
	}
	
	// for the table view. Fri, Jan 1st
	// if multiple days: fri, jan 1st - sat, jan 2nd
	static func formatEventDateOnly(event: Event) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "E, MMM d"
		let startDate = event.startDate
		let endDate = event.endDate
		if (event.fullDay) {
			if (daysBetweenDates(startDate: startDate, endDate: endDate) == 1) {
				return formatter.string(from: startDate)
			} else {
				return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
			}
		} else {
			return formatter.string(from: startDate)
		}
	}
	
	// for table view. 6:00 PM - 8:00 PM
	static func formatEventTimeOnly(event: Event) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "h:mm a"
		let startDate = event.startDate
		let endDate = event.endDate
		return formatter.string(from: startDate) + " - " + formatter.string(from: endDate)
	}
	
	static func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
		let calendar = Calendar.current
		let start = calendar.startOfDay(for: startDate)
		let end = calendar.startOfDay(for: endDate)
		
		let components = calendar.dateComponents([Calendar.Component.day], from: start, to: end)
		return components.day!
	}

	
}
