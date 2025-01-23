//
//  Seasons.swift
//  small-seasons
//
//  Created by Helen V. Holmes on 11/19/23.
//  Inspired by https://smallseasons.guide/.
//

import Foundation

public struct Season {
    public let name: String
    public let japaneseName: String
    public let meaning: String
    public let associations: String
    public let approximateDate: String
}

public func getSeason(for date: String) -> Season? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    
    guard let inputDate = dateFormatter.date(from: date) else {
        return nil
    }

    let smallSeasons: [Season] = [
        Season(name: "Risshun", japaneseName: "立春", meaning: "Start of spring", associations: "Ground thaws, fish appear under ice.", approximateDate: "Feb 4"),
        Season(name: "Usui", japaneseName: "雨水", meaning: "Rain waters", associations: "Snow recedes, mist lingers in the air.", approximateDate: "Feb 18"),
        Season(name: "Keichitsu", japaneseName: "啓蟄", meaning: "Going-out of the worms", associations: "Bugs surface from hibernation.", approximateDate: "Mar 6"),
        Season(name: "Shunbun", japaneseName: "春分", meaning: "Vernal equinox", associations: "Sparrows start to nest, cherry blossoms bloom.", approximateDate: "Mar 21"),
        Season(name: "Seimei", japaneseName: "清明", meaning: "Clear and bright", associations: "Geese fly north, the first rainbows of the year appear.", approximateDate: "Apr 4"),
        Season(name: "Kokū", japaneseName: "穀雨", meaning: "Rain for harvests", associations: "Reeds sprout by rivers, rice seedlings grow.", approximateDate: "Apr 21"),
        Season(name: "Rikka", japaneseName: "立夏", meaning: "Start of summer", associations: "Birds and frogs start the songs of summer.", approximateDate: "May 6"),
        Season(name: "Shōman", japaneseName: "小満", meaning: "Small blooming", associations: "Flowers and plants bloom, wheat ripens.", approximateDate: "May 21"),
        Season(name: "Bōshu", japaneseName: "芒種", meaning: "Seeds and cereals", associations: "Praying mantises hatch, fireflies come out. Time to seed the soil.", approximateDate: "Jun 5"),
        Season(name: "Geshi", japaneseName: "夏至", meaning: "Reaching summer", associations: "Longest days of the year, irises bloom.", approximateDate: "Jun 21"),
        Season(name: "Shōsho", japaneseName: "小暑", meaning: "Small heat", associations: "Warm winds blow, young hawks learn to fly.", approximateDate: "Jul 7"),
        Season(name: "Taisho", japaneseName: "大暑", meaning: "Big heat", associations: "Summer heat at its strongest, accompanied by great rains.", approximateDate: "Jul 23"),
        Season(name: "Risshu", japaneseName: "立秋", meaning: "Start of autumn", associations: "Cooler winds blow, thick fogs roll through hills.", approximateDate: "Aug 8"),
        Season(name: "Shosho", japaneseName: "処暑", meaning: "Lessening heat", associations: "Rice has ripened, the heat of summer, forgotten.", approximateDate: "Aug 23"),
        Season(name: "Hakuro", japaneseName: "白露", meaning: "White dew", associations: "Drops of dew on grass.", approximateDate: "Sep 7"),
        Season(name: "Shubun", japaneseName: "秋分", meaning: "Autumnal equinox", associations: "Day and night are of equal length.", approximateDate: "Sep 23"),
        Season(name: "Kanro", japaneseName: "寒露", meaning: "Cold dew", associations: "Temperatures begin to drop, crickets stop chirping.", approximateDate: "Oct 8"),
        Season(name: "Sōkō", japaneseName: "霜降", meaning: "Frosting", associations: "The first frosts, maple leaves turn yellow.", approximateDate: "Oct 23"),
        Season(name: "Ritto", japaneseName: "立冬", meaning: "Start of winter", associations: "The ground starts to freeze.", approximateDate: "Nov 8"),
        Season(name: "Shōsetsu", japaneseName: "小雪", meaning: "Small snow", associations: "Light snow, the last leaves have fallen from trees.", approximateDate: "Nov 23"),
        Season(name: "Taisetsu", japaneseName: "大雪", meaning: "Big snow", associations: "Cold sets in, bears hibernate.", approximateDate: "Dec 8"),
        Season(name: "Tōji", japaneseName: "冬至", meaning: "Winter solstice", associations: "Shortest days of the year.", approximateDate: "Dec 22"),
        Season(name: "Shōkan", japaneseName: "小寒", meaning: "Small cold", associations: "Temperatures quickly drop.", approximateDate: "Jan 6"),
        Season(name: "Daikan", japaneseName: "大寒", meaning: "Big cold", associations: "Ice thickens on the streams, hens huddle together.", approximateDate: "Jan 20")

    ]

    for season in smallSeasons {
        let startDate = dateFormatter.date(from: season.approximateDate)!
        let endDate = Calendar.current.date(byAdding: .day, value: 13, to: startDate)!

        if inputDate >= startDate && inputDate <= endDate {
            return season
        }
    }

    return nil
}
