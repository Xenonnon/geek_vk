//
//  MySession.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/14/21.
//

import Foundation

class MySession {
    private init() {}
    
    public static let shared = MySession()
    
    var token = ""
    var client_id = -1
    let vAPI = "5.126"
}
