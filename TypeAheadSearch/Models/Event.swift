//
//  Event.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/5/22.
//

import Foundation
import SwiftUI


struct EventsResponse: Decodable {
    let events: [Event]
}

class Event: Decodable, Identifiable
{

    var id: Int
    var title: String
    var datetime_local: String
    var venue: Venue? = nil
    var performers: [Performer]? = []
    var favorite: Bool? = false
    
    init(id: Int, title: String, datetime_local: String) {
        self.id = id
        self.title = title
        self.datetime_local = datetime_local
    }

    
    struct Venue: Codable {
        let display_location: String
    }
    
    struct Performer: Codable {
        let image: String
    }
    
    // MARK: - Methods
    func getDate() -> Date {
        let dateString = datetime_local
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:dateString) ?? Date()
        return date
    }
    
    func getDateString() -> String {
        let date = getDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy h:mm a"
        return dateFormatter.string(from: date).uppercased()
    }
}

