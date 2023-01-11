//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/01/23.
//

import Foundation
import RealmSwift

public class BoardSubTask: Object {
    @Persisted(primaryKey: true) public var _id: ObjectId
    @Persisted public var boardTask_id: ObjectId
    @Persisted public var isComplete: Bool = false
    @Persisted public var owner_id: String?
    @Persisted public var shared_id: List<String>
    @Persisted public var text: String = ""
    
    override init() {}
    
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
