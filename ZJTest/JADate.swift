//
//  JADate.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/16.
//  Copyright © 2016年 庄记. All rights reserved.
//

import Foundation

enum DateType {
    case time
    case date
    case dateTime
}
extension Date {

    static func timeIntervalToDate(timeInterval:TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timeInterval)
    }

    func dateToTimeinterval() -> TimeInterval {
        return self.timeIntervalSince1970
    }

    static func dateTostring(date:Date , _ haveHour:Bool) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = haveHour ? "yyyy-MM-dd HH:mm:ss" : "yyyy-MM-dd"
        return dateformatter.string(from: date)
    }

    static func stringToDate(timeString:String ,_ haveHour:Bool) -> Date {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = haveHour ?  "yyyy-MM-dd HH:mm:ss" : "yyyy-MM-dd"
        return dateformatter.date(from: timeString)!
    }
    
    static func stringToUtcDate(_ time:String) -> Date {
        return Date.timeIntervalToDate(timeInterval: Date.stringToDate(timeString: time, false).timeIntervalSince1970 + 8*60*60)
    }
    
    func utcDateToString() -> String {
        return Date.timeIntervalToDate(timeInterval: (self.timeIntervalSince1970 - 8*60*60)).dateToDateString()
    }
    
    func dateToTimeString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm:ss"
        return dateformatter.string(from: self)
    }
    
    func dateToDateString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-ss"
        return dateformatter.string(from: self)
    }
    
    func dateToDateTimeString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformatter.string(from: self)
    }

    static func stringToStamp(timeString:String) -> TimeInterval {
        let date = Date.stringToDate(timeString: timeString , false)
        return date.dateToTimeinterval()
    }

    static func stampToString(timeInterval:TimeInterval) -> String {
        let date = Date.timeIntervalToDate(timeInterval: timeInterval)
        return Date.dateTostring(date: date ,false)
    }

    func timeIntervalDescription() -> String {
        let timeiInterval = -self.timeIntervalSinceNow
        if timeiInterval < 0  {
            return "错误时间"
        } else if timeiInterval < 60 {
            return "刚刚"
        } else if timeiInterval < 3600 {
            return "\(Int(timeiInterval/60))分钟前"
        } else if timeiInterval < 86400 {
            return "\(Int(timeiInterval/3600))小时前"
        } else if timeiInterval < 604800 {
            return "\(Int(timeiInterval/86400))天前"
        } else if timeiInterval < 2592000 {
            return "\(Int(timeiInterval/604800))周前"
        } else if timeiInterval < 31536000 {
            return "\(timeiInterval/2592000)月前"
        } else {
            return "\(Int(timeiInterval/31536000))年前"
        }
    }

    static func dateToAge(date:Date) -> Int {
        let calender = Calendar(identifier: .chinese)
        let currentDate = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date, to: Date())
        return currentDate.year! + 1
    }
}
