//
//  String+Extension.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/7/22.
//

import Foundation

extension String {
    func trimSpaces() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
