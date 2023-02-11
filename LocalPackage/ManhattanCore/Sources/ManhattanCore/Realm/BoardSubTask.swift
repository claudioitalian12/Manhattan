//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/01/23.
//

import Foundation
import RealmSwift

// MARK: BoardSubTask
public class BoardSubTask: Object {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// board task id.
    @Persisted public var boardTask_id: ObjectId
    /// is complete.
    @Persisted public var isComplete: Bool = false
    /// owner id.
    @Persisted public var owner_id: String?
    /// shared id.
    @Persisted public var shared_id: List<String>
    /// text.
    @Persisted public var text: String = ""
    /// init.
    override init() {}
    /**
        Init BoardSubTask with parameters.

        - Parameter _id: primary key object id.
        - Parameter boardTask_id: boards id.
        - Parameter isComplete: is complete.
        - Parameter owner_id: owner id.
        - Parameter shared_id: shared id.
        - Parameter text:text.
    */
    public init(
        _id: ObjectId = ObjectId.generate(),
        boardTask_id: ObjectId,
        isComplete: Bool,
        owner_id: String? = nil,
        shared_id: List<String>,
        text: String
    ) {
        super.init()
        self._id = _id
        self.boardTask_id = boardTask_id
        self.isComplete = isComplete
        self.owner_id = owner_id
        self.shared_id = shared_id
        self.text = text
    }
}
