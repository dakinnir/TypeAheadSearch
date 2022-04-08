//
//  EventListRow.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventItemRow: View {
    
    // MARK: - Properties
    var event: Event
    @State var isSelected: Bool
    
    var body: some View {
        VStack {
            HStack {
                // Using WebImage with the url image string from the JSON decoded object
                webImageView
                eventInfoView
            }
        }.onAppear {
            isSelected = event.favorite ?? false
        }
    }
    private var eventInfoView: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(event.venue!.display_location)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(event.getDateString())
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private var webImageView: some View {
        WebImage(url: URL(string: event.performers?[0].image ?? ""))
        .resizable()
        .frame(width: 60, height: 60)
        .cornerRadius(5)
        .overlay(alignment: .topLeading) {
            if isSelected {
                favoriteButton
                    .offset(x: -15, y: -10)

            }
            
        }
    }
    
    private var favoriteButton: some View {
        Image(systemName: isSelected ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 20, height: 18)
            .shadow(color: .white, radius: 5, x: 10, y: 10)
            .foregroundColor(Color(Constants.favoriteColor))
    }
}
