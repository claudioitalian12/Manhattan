//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

// MARK: Board
public class Board: Object, ObjectKeyIdentifiable {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// board tasks.
    @Persisted public var boardTasks: RealmSwift.List<BoardTask>
    /// owner id.
    @Persisted public var owner_id: String?
    /// shared id.
    @Persisted public var shared_id: RealmSwift.List<String>
    /// title.
    @Persisted public var title: String = ""
    /// init.
    override public init() {}
    /**
        Init Board with parameters.

        - Parameter _id: primary key object id.
        - Parameter boardTasks: board tasks.
        - Parameter owner_id: owner id.
        - Parameter shared_id: shared id.
        - Parameter title: title.
    */
    public init(
        _id: ObjectId = ObjectId.generate(),
        boardTasks: RealmSwift.List<BoardTask> = RealmSwift.List<BoardTask>(),
        owner_id: String? = nil,
        shared_id: RealmSwift.List<String>,
        title: String
    ) {
        super.init()
        self._id = _id
        self.boardTasks = boardTasks
        self.owner_id = owner_id
        self.shared_id = shared_id
        self.title = title
    }
}
