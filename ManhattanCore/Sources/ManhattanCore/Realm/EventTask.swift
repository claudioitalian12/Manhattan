//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import Foundation
import RealmSwift

public class EventTask: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var event_id: ObjectId
    @Persisted public var isCompleted: Bool
    @Persisted public var isNew: Bool
    @Persisted public var owner_id: String?
    @Persisted public var text: String
    
    override public init() {}
    
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
