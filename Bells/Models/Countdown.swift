//
//  Countdown.swift
//  Monta Vista Bells
//
//  Created by Carolyn Duan on 6/12/17.
//  Copyright © 2017 Carolyn Duan. All rights reserved.
//
//	Holds all data necessary for the countdown to work — seconds left, current block (so Schedules view controller can access it), etc..

import Foundation


struct Count {
	/// day of week: 1 is sunday, 2 is monday, 3 tues, 4 wed, 5 thurs, 6 fri, 7 sat
	static var day: Int = ScheduleHelper.getDayOfWeek()
    // static var day: Int = 5;  where forces day   1/3
    
	/// number of seconds left until the next block starts
	static var secondsLeft: Int {
		get {
			let secLeftAndBlock: (Int, Int) = ScheduleHelper.secondsLeftUntilNextBlock(day, currentHourMinSec: ScheduleHelper.getCurrentHMS())
			return secLeftAndBlock.1
		}
		set (newSeconds) {
			self.secondsLeft = newSeconds
		}
	}
	
	/// a block of time — a period, brunch, lunch, passing pd. zero-indexed
	static var currentBlock: Int {
		get {
			let secLeftAndBlock: (Int, Int) = ScheduleHelper.secondsLeftUntilNextBlock(day, currentHourMinSec: ScheduleHelper.getCurrentHMS())
			return secLeftAndBlock.0
		}
		
		set(newBlock) {
			self.currentBlock = newBlock
		}
	}
	
}
