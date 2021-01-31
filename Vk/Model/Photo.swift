//
//  Photo.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/28/21.
//

import Foundation
import SwiftyJSON

struct Photo {
    let id: Int
    let sizes: [PhotoSize]
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.sizes = json["sizes"].arrayValue.compactMap { PhotoSize($0) }
    }
}

struct PhotoSize {
    let type: String
    let height: Int
    let width: Int
    let url: String
    
    init(_ json: JSON) {
        self.type = json["type"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["url"].stringValue
    }
}
