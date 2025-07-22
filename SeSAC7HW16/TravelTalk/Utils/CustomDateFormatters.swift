//
//  DateFormatters.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/23/25.
//

import Foundation

struct DateFormatters {
    static let inputFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        df.locale = Locale(identifier: "ko_KR")
        return df
    }()

    static let outputDateTypeFormatter: DateFormatter = {
		let df = DateFormatter()
        df.dateFormat = "yy.MM.dd"
        df.locale = Locale(identifier: "ko_KR")
        return df
    }()

    static let outputTimeTypeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm a"
        df.locale = Locale(identifier: "ko_KR")
        return df
    }()
}
