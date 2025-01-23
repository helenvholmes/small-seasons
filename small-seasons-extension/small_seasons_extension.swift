//
//  small_seasons_extension.swift
//  small-seasons-extension
//
//  Created by Helen V. Holmes on 11/20/23.
//

import WidgetKit
import SwiftUI
import small_seasons

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct small_seasons_extensionEntryView : View {
    @State private var currentDate = Date()
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let season = small_seasons.getSeason(for: formattedDate) {
                Text("Current Season: \(season.name)")
                    .padding()
                Text("\(season.japaneseName)")
            } else {
                Text("Invalid date format or season not found.")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding()
            }

            Text("Emoji:")
            Text(entry.emoji)
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
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
