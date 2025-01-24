//
//  ContentView.swift
//  small-seasons
//
//  Created by Helen V. Holmes on 11/19/23.
//
    
import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date()
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
        VStack {
            if let season = getSeason(for: formattedDate) {
                Text("\(season.japaneseName) · \(season.name)").font(Font.title3.weight(.black)).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                Text("\(season.meaning)").font(Font.caption.weight(.light)).italic()
                Text("\(season.associations)").padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50)).font(Font.caption.weight(.light)).multilineTextAlignment(.center).italic()
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
