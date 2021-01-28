//
//  Groups.swift
//  Vk
//
//  Created by Евгений Дербенев on 23.12.2020.
//

import UIKit
import SwiftyJSON

struct Group {
    let id: Int
    let name: String
    let photo100: String
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo100 = json["photo_100"].stringValue
    }
}

extension Group: Equatable {}



struct AllGroups {
    let name: String
    let image: UIImage?
}

struct AllGroupsSections {
    var title: String
    var items: [AllGroups]
    
}

final class Groups {
    static func makeGroups() -> [AllGroups] {
        let gr1 = AllGroups(name: "111111", image: UIImage(named: "darth-vader"))
        let gr2 = AllGroups(name: "Apple", image: UIImage(named: "darth-vader"))
        let gr3 = AllGroups(name: "4ch", image: UIImage(named: "4ch"))
        let gr4 = AllGroups(name: "lalalend", image: UIImage(named: "camera"))
        return [gr1,gr2,gr3,gr4]
    }
}

