//
//  String + Extensions.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation

extension String {
    func formattedDate(inputFormat: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat

        if let inputDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: inputDate)
        }
        
        return nil
    }
}

extension String {
    /// Converts a Gregorian date string to a formatted Hijri (Islamic) date string.
    ///
    /// - Parameters:
    ///   - inputFormat: The input date format of the Gregorian date string.
    ///   - outputFormat: The desired output format for the Hijri date string. Use "dd" for day,
    ///     "MMM" for abbreviated month name, and "yyyy" for year. You can use line breaks ("\n")
    ///     in the output format to separate the date components.
    /// - Returns: The formatted Hijri date string or nil if the conversion fails.

    func formattedHijriDate(inputFormat: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat

        if let inputDate = dateFormatter.date(from: self) {
            let calendar = Calendar(identifier: .islamicUmmAlQura)
            let components = calendar.dateComponents([.year, .month, .day], from: inputDate)
            
            let hijriYear = components.year!
            let hijriMonth = components.month!
            let hijriDay = components.day!
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ar_SA")
            formatter.calendar = calendar
            formatter.dateFormat = "MMM"
            let hijriMonthSymbol = formatter.string(from: calendar.date(from: components)!)
            
            let formattedHijriDate = outputFormat
                .replacingOccurrences(of: "dd", with: String(format: "%02d", hijriDay))
                .replacingOccurrences(of: "MMM", with: hijriMonthSymbol)
                .replacingOccurrences(of: "yyyy", with: String(format: "%04d", hijriYear))
            
            return formattedHijriDate
        }
        
        return nil
    }
}



