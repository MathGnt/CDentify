//
//  File.swift
//  Features
//
//  Created by Mathis Gaignet on 31/07/2025.
//

import Foundation
import SwiftUI
import Entities

struct CDDetail: View {
    let cd: CD
    var body: some View {
        ScrollView {
            VStack {
                Text(cd.title)
                Text(cd.artist.name)
                Text(cd.artist.members.first ?? "UNKNOWN")
                Text(cd.releaseDate)
                Text(cd.packaging ?? "No package")
            }
            ForEach(cd.tracks) { track in
                HStack {
                    Text(track.title)
                    Text(track.position, format: .number.precision(.fractionLength(1)))
                }
            }
            ForEach(cd.artist.recentShows) { show in
                HStack {
                    Text(show.date)
                    Text(show.location.city)
                    Text(show.location.venue)
                    Text(show.playedSongs[4])
                }
            }
        }
    }
}
