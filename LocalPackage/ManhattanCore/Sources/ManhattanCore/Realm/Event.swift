//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import RealmSwift
import SwiftUI

public class Event: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var color: String
    @Persisted public var date: Date
    @Persisted public var owner_id: String?
    @Persisted public var symbol: String
    @Persisted public var tasks: RealmSwift.List<EventTask> = RealmSwift.List<EventTask>()
    @Persisted public var title: String
    @Persisted public var todo_id: ObjectId

    public var colorOption: Color {
        ColorOptions(rawValue: color)?.color ?? .primary
    }
    
    public var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    public var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    
    public var isPast: Bool {
        date < Date.now
    }
    
    public var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    
    public var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    
    public var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }
    
    public var dateFormatted: String {
        date.formatted(
        date: .abbreviated,
        time: .shortened
        )
    }
        
    override public init() { }
    
    public init(
        _id: ObjectId = ObjectId.generate(),
        color: String = ColorOptions.primary.rawValue,
        date: Date = Date(),
        owner_id: String? = nil,
        symbol: String = EventSymbols.randomName,
        tasks: RealmSwift.List<EventTask> = RealmSwift.List<EventTask>(),
        title: String = "",
        todo_id: ObjectId = ObjectId.generate(),
        realm: Realm? = nil
    ) {
        super.init()
        self._id = _id
        self.color = color
        self.date = date
        self.owner_id = owner_id
        self.symbol = symbol
        self.tasks = tasks
        self.title = title
        self.todo_id = todo_id
    }
}
