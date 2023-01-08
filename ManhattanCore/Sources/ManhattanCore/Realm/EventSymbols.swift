//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import Foundation

public enum EventSymbols: String, CaseIterable {
    public typealias RawValue = String
    
    case house = "house.fill"
    case ticket = "ticket.fill"
    case gamecontroller = "gamecontroller.fill"
    case theatermasks = "theatermasks.fill"
    case ladybug = "ladybug.fill"
    case books = "books.vertical.fill"
    case moon = "moon.zzz.fill"
    case umbrella = "umbrella.fill"
    case paintbrush = "paintbrush.pointed.fill"
    case leaf = "leaf.fill"
    case globe = "globe.americas.fill"
    case clock =  "clock.fill"
    case building = "building.2.fill"
    case gift = "gift.fill"
    case graduationcap = "graduationcap.fill"
    case heart = "heart.rectangle.fill"
    case phone = "phone.bubble.left.fill"
    case cloud = "cloud.rain.fill"
    case buildingColumns = "building.columns.fill"
    case mic = "mic.circle.fill"
    case comb = "comb.fill"
    case person = "person.3.fill"
    case bell = "bell.fill"
    case hammer = "hammer.fill"
    case star = "star.fill"
    case crown = "crown.fill"
    case briefcase = "briefcase.fill"
    case speaker = "speaker.wave.3.fill"
    case tshirt = "tshirt.fill"
    case tag = "tag.fill"
    case airplane = "airplane"
    case pawprint = "pawprint.fill"
    case caseFill = "case.fill"
    case creditcard = "creditcard.fill"
    case infinity = "infinity.circle.fill"
    case dice = "dice.fill"
    case heartFill = "heart.fill"
    case camera = "camera.fill"
    case bicycle = "bicycle"
    case radio = "radio.fill"
    case car = "car.fill"
    case flag = "flag.fill"
    case map = "map.fill"
    case figure = "figure.wave"
    case mappin = "mappin.and.ellipse"
    case facemask = "facemask.fill"
    case eyeglasses = "eyeglasses"
    case tram = "tram.fill"

    public static var randomName: String {
        if let random = EventSymbols.allCases.randomElement() {
            return random.rawValue
        } else {
            return "slowmo"
        }
    }
    
    public static func randomNames(_ number: Int) -> [String] {
        var names: [String] = []
        for _ in 0..<number {
            names.append(EventSymbols.randomName)
        }
        return names
    }
}
