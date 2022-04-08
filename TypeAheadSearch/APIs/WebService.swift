//
//  WebService.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/5/22.
//

import Foundation


class WebService {
    
    // MARK: - Properties
    static let shared = WebService().self
    private var dataTask: URLSessionDataTask?
    
    func fetchEventsData(searchText: String) async throws -> [Event] {
        
        // Construct the full url with clientId and searchText
        guard let url = URL(string: "\(Constants.baseUrl)?client_id=\(Constants.clientId)&q=\(searchText.replacingOccurrences(of: " ", with: "+"))") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let eventsData = try? JSONDecoder().decode(EventsResponse.self, from: data)

        guard let events = eventsData?.events else {
            return []
        }
        return events
    }
}
