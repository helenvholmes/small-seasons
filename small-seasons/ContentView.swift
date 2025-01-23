//
//  ContentView.swift
//  small-seasons
//
//  Created by Helen V. Holmes on 11/19/23.
//
    
import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            Text(formattedDate)
            
            if let season = getSeason(for: formattedDate) {
                Text("Current Season: \(season.name)")
                    .padding()
                Text("\(season.japaneseName)")
                Text("\(season.meaning)")
                Text("\(season.associations)")
                Text("Start date: \(season.approximateDate)")
            } else {
                Text("Invalid date format or season not found.")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding()
            }
        }
        .padding()
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: currentDate)
    }
}

#Preview {
    ContentView()
}
