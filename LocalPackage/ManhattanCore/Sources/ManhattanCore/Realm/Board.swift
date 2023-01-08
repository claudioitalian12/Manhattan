//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

public class Board: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var boardTasks: RealmSwift.List<BoardTask>
    @Persisted public var owner_id: String?
    @Persisted public var shared_id: RealmSwift.List<String>
    @Persisted public var title: String = ""
    
    override public init() {}
    
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
