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
        ZStack(alignment: .center) {
            LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            if let season = getSeason(for: formattedDate) {
                VStack(alignment: .center) {
                    Text("\(season.japaneseName) · \(season.name)").font(Font.caption.weight(.black)).padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 10))
                    Text((season.meaning)).font(Font.caption.weight(.light)).multilineTextAlignment(.center).italic().padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                }.background(.white)

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
        .contentMarginsDisabled() // Removes content margins
        .configurationDisplayName("Small Seasons")
        .description("Current sekki.")
    }
}

#Preview(as: .systemSmall) {
    small_seasons_extension()
} timeline: {
    SimpleEntry(date: .now)
}
