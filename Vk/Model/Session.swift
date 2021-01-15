//
//  Session.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/14/21.
//

import Foundation

class Session {
    private init() { }
    
    public static let shared = Session()
    
    var token = "qwerty"
    var userId = 0
}
