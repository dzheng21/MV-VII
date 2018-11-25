//
//  EventsTableViewController.swift
//  Bells
//
//  Created by Carolyn DUan on 1/6/17.
//  Copyright © 2017 Carolyn Duan. All rights reserved.
//  TODO: if today is a holiday,  "schools out" message

import UIKit
import Alamofire
import SwiftyJSON

class EventsTableViewController: UITableViewController {
    
    fileprivate let kKeychainItemName = "Google Calendar API"
    fileprivate let apiKey = "AIzaSyA7O0BEo05XhiBnhxhR1ECr59ShhzkONsI"
    fileprivate let calendarId = "g7rot53rcqrj4p8jirvt3gl2ck@group.calendar.google.com"
    
    /// An array that contains the UIColors to be used as headers for the Event cells
    /// An array to hold all events occuring within 3 months of current date.
    var eventArray: [Event] = []
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = .none
        
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        self.indicator.startAnimating()
        
        performRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func performRequest() {
        let params: Parameters = [
            "key": apiKey,
            "timeMax": EventHelper.calculateMaxTime(months: 3),
            "timeMin": EventHelper.dateToRFC3339(date: Date()),
            "singleEvents": "true",
            "orderBy": "startTime"
        ]
        
        let url = "https://www.googleapis.com/calendar/v3/calendars/\(calendarId)/events"
        
        Alamofire.request(url, parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let events = json["items"].arrayValue
                    
                    for eventJSON in events {
                        //if (EventHelper.eventIsRelevant(json: eventJSON)) { // changed this
                            let event: Event = Event(json: eventJSON)
                            //print(event)
                            self.eventArray.append(event)
                        //}
                    }
                    
                } else {
                    print("uh oh something went wrong")
                }
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            case .failure(let error):
                print("o no error")
                print(error)
            }
            self.tableView.reloadData()
        }
    }
    
    /// Returns true if event is not sports-related (has a "vs." or "@" or SANP planning) and returns false if otherwise
    private func eventIsRelevant(json: JSON) -> Bool {
        let name = json["summary"].stringValue
        return (name.range(of: "@") == nil && name.range(of: "vs.") == nil && name.range(of: "Senior All Night Party") == nil) ? true : false
    }
    
    private func dateToRFC3339(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T00:00:00-08:00" // TODO: idk when i would use this besides timeMin
        print(formatter.string(from: date as Date))
        return formatter.string(from: date as Date)
    }
    
    private func rfc3339ToDate(timestamp: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let start = timestamp.index(timestamp.startIndex, offsetBy: 19)
        return formatter.date(from: timestamp.substring(to: start))!
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1 // self.eventArray.count > 0 ? self.eventArray.count : 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        // proceed if there are events in the array.
        if self.eventArray.count > 0
        {
            // set color of event header
            let index = indexPath.section % 5
            cell.eventColorView.backgroundColor = Colors.colorArray[index]
            
            let event = self.eventArray[indexPath.section]
            cell.descLabel.text = "\(event.name)"
            cell.locationLabel.text = "\(event.location)"
            let dateString = "\(EventHelper.formatEventDateOnly(event: event))"
            let timeString = EventHelper.formatEventTimeOnly(event: event)
            // cell.startLabel.text = "\(EventHelper.formatEventDateOnly(event: event))"
            // TODO: only format event time if !event.fullDay O I GOTEM
            cell.startLabel.text = dateString
            
            if (!event.fullDay)
                // TODO: determining if event is a full day doesn't work yet
            {
                let normalDate = NSMutableAttributedString(string: dateString)
                let hours = NSMutableAttributedString(string: timeString, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
                normalDate.append(NSMutableAttributedString(string: "\n"))
                normalDate.append(hours)
                cell.startLabel.attributedText = normalDate
            }
        }
        else
        {
            cell.descLabel.text = "Loading.."
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
