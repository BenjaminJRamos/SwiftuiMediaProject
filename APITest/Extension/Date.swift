//
//  Date.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/21/23.
//

import Foundation

extension Date {
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM:dd:yy"
        return formatter
    }
    
    // FUNCTIONS TO RETURN TIMESTAMPS
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dayString() -> String {
        return dayFormatter.string(from: self)
    }
    
    //  FUNTION THAT DETERMINS WHICH TYPE OF DATE TO RETURN
    func timeStampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dayString()
        }
    }
}

