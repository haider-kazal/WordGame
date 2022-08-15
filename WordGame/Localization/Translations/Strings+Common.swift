//
//  Strings+Common.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

extension Strings {
    enum Common: String, StringsProtocol {
        case pleaseWait = "Common - Please Wait"
        case processing = "Common - Processing"
        case yes = "Common - Yes"
        case no = "Common - No"
        case ok = "Common - OK"
        case cancel = "Common - Cancel"
        case next = "Common - Next"
        case submit = "Common - Submit"
        case previous = "Common - Previous"
        case failed = "Common - Failed"
        case back = "Common - Back"
        case confirm = "Common - Confirm"
        case somethingWentWrong = "Common - Something went wrong"
        case done = "Common - Done"
        
        
        var lookupTableName: String { "CommonLocalizable" }
        
        var localized: String {
            let text = Strings.text(
                forKey: rawValue,
                defaultValue: nil,
                fromTable: lookupTableName
            )
            return text
        }
    }
}
