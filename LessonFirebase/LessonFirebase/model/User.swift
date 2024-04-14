//
//  User.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 13/4/24.
//

import Foundation

class User: NSObject {
    var id = ""
    var email = ""
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
    }
}


