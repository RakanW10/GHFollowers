//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 19/11/1445 AH.
//

import Foundation

extension String {
    var convertToDate: Date? { ISO8601DateFormatter().date(from: self) }
}
