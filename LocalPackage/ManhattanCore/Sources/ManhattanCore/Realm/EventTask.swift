//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import Foundation
import RealmSwift

// MARK: EventTask
public class EventTask: Object, ObjectKeyIdentifiable {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// event id.
    @Persisted public var event_id: ObjectId
    /// is completed.
    @Persisted public var isCompleted: Bool
    /// is new.
    @Persisted public var isNew: Bool
    /// owner id.
    @Persisted public var owner_id: String?
    /// text.
    @Persisted public var text: String
    /// init.
    override public init() {}
    /**
        Init EventTask with parameters.

        - Parameter _id: primary key object id.
        - Parameter event_id: event id.
        - Parameter isCompleted: is completed.
        - Parameter isNew: is new.
        - Parameter owner_id: owner id.
        - Parameter text:text.
    */
    public init(
        _id: ObjectId = ObjectId.generate(),
        event_id: ObjectId,
        isCompleted: Bool = false,
        isNew: Bool = false,
        owner_id: String? = nil,
        text: String = ""
    ) {
        super.init()
        self._id = _id
        self.event_id = event_id
        self.isCompleted = isCompleted
        self.isNew = isNew
        self.owner_id = owner_id
        self.text = text
    }
}
