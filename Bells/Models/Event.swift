//
//  Event.swift
//  CarolynQuickstartApp
//
//  Created by Carolyn DUan on 12/28/16.
//  Copyright © 2016 com.example. All rights reserved.
//

// breaks - week-long, staff learning day, holidays
// ap testing
// finals week (should probably have a finals schedule or something)
// dances, concerts, show, orchestra, musical
// senior prom, junior prom
// rallies, spirit weeks


import Foundation
import SwiftyJSON

struct Event {
	
	let name: String // summary
	let startDate: Date // o should these be NSDates
	let endDate: Date // ok wait if it has an endDate then it's a full-day thing that has MULTIPLE days
	let fullDay: Bool
    let location: String
	
	init(json: JSON) {
        print(json)
        self.location = json["description"].stringValue
		self.name = json["summary"].stringValue
		
		if json["start"]["date"].exists() {
			self.startDate = EventHelper.shortToDate(timestamp: json["start"]["date"].stringValue)
			self.fullDay = true
		} else {
			self.startDate = EventHelper.rfc3339ToDate(timestamp: json["start"]["dateTime"].stringValue)
			self.fullDay = false
		}
		
		self.endDate = (json["end"]["date"].exists()) ? EventHelper.shortToDate(timestamp: json["end"]["date"].stringValue) : EventHelper.rfc3339ToDate(timestamp: json["end"]["dateTime"].stringValue)
		// self.endDate = json["end"]["date"].stringValue
	}
	
}
