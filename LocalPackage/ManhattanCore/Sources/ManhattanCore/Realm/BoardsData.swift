//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

// MARK: BoardsData
public class BoardsData: Object, ObjectKeyIdentifiable {
    /// _id object.
    @Persisted(primaryKey: true) public var _id: ObjectId
    /// boards list.
    @Persisted public var boards: RealmSwift.List<Board>
    /// owner id.
    @Persisted public var owner_id: String?
    /// init.
    override public init() {}
    /**
        Init BoardData with parameters.

        - Parameter _id: primary key object id.
        - Parameter boards: boards list.
        - Parameter owner_id: owner id.
    */
    public init(
        _id: ObjectId = ObjectId.generate(),
        boards: RealmSwift.List<Board> = RealmSwift.List<Board>(),
        owner_id: String? = nil
    ) {
        super.init()
        self._id = _id
        self.boards = boards
        self.owner_id = owner_id
    }
}
