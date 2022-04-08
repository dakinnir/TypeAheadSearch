//
//  EventDetailView.swift
//  TypeAheadSearch
//
//  Created by Daniel Akinniranye on 4/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventDetailView: View {

    var event: Event
    @State var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            titleViewSection
            webImageView
                .padding()
            bottomDetailView
            Spacer()
        }
        .padding()
        .navigationTitle(Constants.detailViewTitle)
    }

    private var favoriteButton: some View {
        Button {
            isSelected.toggle()
        } label: {
            Image(systemName: isSelected ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(Constants.favoriteColor))
        }.onChange(of: isSelected) { newValue in
            event.favorite = newValue
            UserDefaults.standard.set(event.favorite, forKey: String(event.id))
        }
    }
    
    private var titleViewSection: some View {
        HStack {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            favoriteButton
        }
    }

    private var webImageView: some View {
        VStack {
            WebImage(url: URL(string: event.performers![0].image))
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
        }
    }

    
    private var bottomDetailView: some View {
        VStack(alignment: .leading) {
            Text(event.getDateString())
                .font(.title)
                .fontWeight(.bold)
                .textCase(.uppercase)
            
            Text(event.venue!.display_location)
                .font(.title3)
                .fontWeight(.light)
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: EventListViewModel.init().events.first!, isSelected: false)
    }
}
