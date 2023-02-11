//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import RealmSwift
import SwiftUI

// MARK: Event
public class Event: Object, ObjectKeyIdentifiable {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// color.
    @Persisted public var color: String
    /// date.
    @Persisted public var date: Date
    /// owner id.
    @Persisted public var owner_id: String?
    /// symbol.
    @Persisted public var symbol: String
    /// tasks.
    @Persisted public var tasks: RealmSwift.List<EventTask> = RealmSwift.List<EventTask>()
    /// title.
    @Persisted public var title: String
    /// todo_id.
    @Persisted public var todo_id: ObjectId
    /// color option.
    public var colorOption: Color {
        ColorOptions(rawValue: color)?.color ?? .primary
    }
    /// remaining task count.
    public var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    /// is complete.
    public var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    /// is past.
    public var isPast: Bool {
        date < Date.now
    }
    /// is within seven days.
    public var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    /// is within seven to thirty days.
    public var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    /// is distant.
    public var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }
    /// date formatted.
    public var dateFormatted: String {
        date.formatted(
        date: .abbreviated,
        time: .shortened
        )
    }
    /// init.
    override public init() { }
    /**
        Init Event with parameters.

        - Parameter _id: primary key object id.
        - Parameter color: color.
        - Parameter date: data.
        - Parameter owner_id: owner id.
        - Parameter symbol: symbol.
        - Parameter tasks: tasks.
        - Parameter title: title.
        - Parameter todo_id: todo id.
        - Parameter realm: realm.
    */
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
