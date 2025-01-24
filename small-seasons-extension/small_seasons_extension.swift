//
//  small_seasons_extension.swift
//  small-seasons-extension
//
//  Created by Helen V. Holmes on 11/20/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
        
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct small_seasons_extensionEntryView : View {
    @State private var currentDate = Date()
    @State private var animateGradient = false
    var entry: Provider.Entry

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
                Text("\(season.japaneseName) · \(season.name)").font(Font.title3.weight(.black))
            } else {
                Text("Invalid date format or season not found.")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding()
            }
        }
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: currentDate)
    }
}

struct small_seasons_extension: Widget {
    let kind: String = "small_seasons_extension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                small_seasons_extensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                small_seasons_extensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    small_seasons_extension()
} timeline: {
    SimpleEntry(date: .now)
}
