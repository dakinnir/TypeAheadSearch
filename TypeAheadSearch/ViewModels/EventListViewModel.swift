//
//  EventListViewModel.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/5/22.
//

import Combine
import Foundation
import SwiftUI

class EventListViewModel: ObservableObject {
    
    // MARK: - Properties
        
    /// EventListView given permission to read only
    @Published public private(set) var events: [Event] = []
    private let webService: WebService = WebService()
    
    // MARK: - Actions
    
    /// Function call for fetching the data from Seat Geek API
    func getEvents(searchText: String) async {
        do {
            let events = try? await WebService.shared.fetchEventsData(searchText: searchText)
            DispatchQueue.main.async {
                self.events = events.map([Event].init) ?? []
                _ = self.events.map {
                    $0.favorite = UserDefaults.standard.bool(forKey: String($0.id))
                }
            }
        }
    }
    
}
