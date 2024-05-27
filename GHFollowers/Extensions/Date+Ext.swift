//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 19/11/1445 AH.
//

import Foundation

extension Date {
    var convertToMonthYearFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
