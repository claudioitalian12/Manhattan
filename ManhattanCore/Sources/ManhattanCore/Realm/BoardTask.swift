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
    @Persisted public var board_id: ObjectId
    @Persisted public var owner_id: String?
    @Persisted public var shared_id: RealmSwift.List<String>
    @Persisted public var status: String = ""
    @Persisted public var text: String = ""
    @Persisted public var title: String = ""
    
    override public init() {}
    
    public init(
        _id: ObjectId,
        assigned_id: String? = nil,
        board_id: ObjectId,
        owner_id: String? = nil,
        shared_id: RealmSwift.List<String>,
        status: String,
        text: String,
        title: String
    ) {
        super.init()
        self._id = _id
        self.assigned_id = assigned_id
        self.board_id = board_id
        self.owner_id = owner_id
        self.shared_id = shared_id
        self.status = status
        self.text = text
        self.title = title
    }
}
