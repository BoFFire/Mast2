//
//  StripHTML.swift
//  Mast
//
//  Created by Shihab Mehboob on 17/09/2019.
//  Copyright © 2019 Shihab Mehboob. All rights reserved.
//

import Foundation

extension String {
    func stripHTML() -> String {
        var z = self.replacingOccurrences(of: "</p><p>", with: "\n\n", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "<br>", with: "\n", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "<br />", with: "\n", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "<br/>", with: "\n", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "<[^>]+>", with: "", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "&apos;", with: "'", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "&quot;", with: "\"", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "&amp;", with: "&", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "&lt;", with: "<", options: NSString.CompareOptions.regularExpression, range: nil)
        z = z.replacingOccurrences(of: "&gt;", with: ">", options: NSString.CompareOptions.regularExpression, range: nil)
        return z
    }
}
