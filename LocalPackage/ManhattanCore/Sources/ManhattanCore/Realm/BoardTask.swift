//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

public class BoardTask: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var assigned_id: String?
    @Persisted public var attachments: List<String>
    @Persisted public var boardSubTasks: List<BoardSubTask>
    @Persisted public var board_id: ObjectId
    @Persisted public var comments: List<String>
    @Persisted public var owner_id: String?
    @Persisted public var shared_id: List<String>
    @Persisted public var status: String = ""
    @Persisted public var text: String = ""
    @Persisted public var title: String = ""

    override public init() {}
    
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
