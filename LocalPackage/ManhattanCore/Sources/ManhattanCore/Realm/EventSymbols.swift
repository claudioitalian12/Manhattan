//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import Foundation

// MARK: EventSymbols
public enum EventSymbols: String, CaseIterable {
    /// raw value.
    public typealias RawValue = String
    /// house.
    case house = "house.fill"
    /// ticket.
    case ticket = "ticket.fill"
    /// gamecontroller.
    case gamecontroller = "gamecontroller.fill"
    /// theatermasks.
    case theatermasks = "theatermasks.fill"
    /// ladybug.
    case ladybug = "ladybug.fill"
    /// books.
    case books = "books.vertical.fill"
    /// moon.
    case moon = "moon.zzz.fill"
    /// umbrella.
    case umbrella = "umbrella.fill"
    /// paintbrush.
    case paintbrush = "paintbrush.pointed.fill"
    /// leaf.
    case leaf = "leaf.fill"
    /// globe.
    case globe = "globe.americas.fill"
    /// clock.
    case clock =  "clock.fill"
    /// building.
    case building = "building.2.fill"
    /// gift.
    case gift = "gift.fill"
    /// graduationcap.
    case graduationcap = "graduationcap.fill"
    /// heart.
    case heart = "heart.rectangle.fill"
    /// phone.
    case phone = "phone.bubble.left.fill"
    /// cloud.
    case cloud = "cloud.rain.fill"
    /// buildingColumns.
    case buildingColumns = "building.columns.fill"
    /// mic.
    case mic = "mic.circle.fill"
    /// comb.
    case comb = "comb.fill"
    /// person.
    case person = "person.3.fill"
    /// bell.
    case bell = "bell.fill"
    /// hammer.
    case hammer = "hammer.fill"
    /// star.
    case star = "star.fill"
    /// crown.
    case crown = "crown.fill"
    /// briefcase.
    case briefcase = "briefcase.fill"
    /// speaker.
    case speaker = "speaker.wave.3.fill"
    /// tshirt.
    case tshirt = "tshirt.fill"
    /// tag.
    case tag = "tag.fill"
    /// airplane.
    case airplane = "airplane"
    /// pawprint.
    case pawprint = "pawprint.fill"
    /// caseFill.
    case caseFill = "case.fill"
    /// creditcard.
    case creditcard = "creditcard.fill"
    /// infinity.
    case infinity = "infinity.circle.fill"
    /// dice.
    case dice = "dice.fill"
    /// heartFill.
    case heartFill = "heart.fill"
    /// camera.
    case camera = "camera.fill"
    /// bicycle.
    case bicycle = "bicycle"
    /// radio.
    case radio = "radio.fill"
    /// car.
    case car = "car.fill"
    /// flag.
    case flag = "flag.fill"
    /// map.
    case map = "map.fill"
    /// figure.
    case figure = "figure.wave"
    /// mappin.
    case mappin = "mappin.and.ellipse"
    /// facemask.
    case facemask = "facemask.fill"
    /// eyeglasses.
    case eyeglasses = "eyeglasses"
    /// tram.
    case tram = "tram.fill"
    /// random name.
    public static var randomName: String {
        if let random = EventSymbols.allCases.randomElement() {
            return random.rawValue
        } else {
            return "slowmo"
        }
    }
    /**
        RandomNames with parameters.

        - Parameter randomNames: number.
    */
    public static func randomNames(_ number: Int) -> [String] {
        var names: [String] = []
        for _ in 0..<number {
            names.append(EventSymbols.randomName)
        }
        return names
    }
}
