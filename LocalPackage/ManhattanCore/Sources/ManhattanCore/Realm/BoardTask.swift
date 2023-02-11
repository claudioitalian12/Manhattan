//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

// MARK: BoardTask
public class BoardTask: Object, ObjectKeyIdentifiable {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// assigned id.
    @Persisted public var assigned_id: String?
    /// attachments.
    @Persisted public var attachments: List<String>
    /// board sub tasks.
    @Persisted public var boardSubTasks: List<BoardSubTask>
    /// board id.
    @Persisted public var board_id: ObjectId
    /// comments.
    @Persisted public var comments: List<String>
    /// owner id.
    @Persisted public var owner_id: String?
    /// shared id.
    @Persisted public var shared_id: List<String>
    /// status.
    @Persisted public var status: String = ""
    /// text.
    @Persisted public var text: String = ""
    /// title.
    @Persisted public var title: String = ""
    /// init.
    override public init() {}
    /**
        Init BoardTask with parameters.

        - Parameter _id: primary key object id.
        - Parameter assigned_id: assigned id.
        - Parameter attachments: attachments.
        - Parameter boardSubTasks: board sub tasks.
        - Parameter board_id: board id.
        - Parameter comments: comments.
        - Parameter owner_id: owner id.
        - Parameter shared_id: shared id.
        - Parameter status: status.
        - Parameter text: text.
        - Parameter title: title.
    */
    public init(
        _id: ObjectId = ObjectId.generate(),
        assigned_id: String? = nil,
        attachments: List<String>,
        boardSubTasks: List<BoardSubTask>,
        board_id: ObjectId,
        comments: List<String>,
        owner_id: String? = nil,
        shared_id: List<String>,
        status: String,
        text: String,
        title: String
    ) {
        super.init()
        self._id = _id
        self.assigned_id = assigned_id
        self.attachments = attachments
        self.boardSubTasks = boardSubTasks
        self.board_id = board_id
        self.comments = comments
        self.owner_id = owner_id
        self.shared_id = shared_id
        self.status = status
        self.text = text
        self.title = title
    }
}
