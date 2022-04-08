//
//  ContentView.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/4/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var eventListViewModel: EventListViewModel = EventListViewModel()
    @State private var searchText: String = ""

    init() {
        // Initial setup
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.init(Color(Constants.navigationBarColor))
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(.white)
    }
    
    var body: some View {
        eventListView
    }
    
    /// Empty List View when no events are present
    private var emptyListView: some View {
        Text("Nothing Searched")
            .font(.headline)
            .foregroundColor(.secondary)
            .navigationTitle(Constants.eventListViewTitle).navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
    }
    
    /// Event List View when  events are present
    private var eventListView: some View {
        List(eventListViewModel.events) { event in
            NavigationLink {
                // Destination
                EventDetailView(event: event, isSelected: event.favorite ?? false)
            } label: {
                // Row view
                EventItemRow(event: event, isSelected: event.favorite ?? false)
            }
        }
        .listStyle(.automatic)
        // Search bar for queries
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Constants.promptText)
        .onChange(of: searchText) { text in
            // Use to search for results when text changes
            Task { await eventListViewModel.getEvents(searchText: text) }
        }
        .navigationTitle(Constants.eventListViewTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
