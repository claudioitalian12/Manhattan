//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 06/01/23.
//

import Foundation
import RealmSwift

public class BoardsData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var boards: RealmSwift.List<Board>
    @Persisted public var owner_id: String?
    
    override public init() {}
    
    public init(
        _id: ObjectId,
        boards: RealmSwift.List<Board>,
        owner_id: String? = nil
    ) {
        super.init()
        self._id = _id
        self.boards = boards
        self.owner_id = owner_id
    }
}
