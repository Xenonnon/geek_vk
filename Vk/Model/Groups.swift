//
//  Groups.swift
//  Vk
//
//  Created by Евгений Дербенев on 23.12.2020.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var  id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var photo100: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo100 = json["photo_100"].stringValue
    }
    
    convenience init(id: Int, name: String, photo100: String) {
        self.init()
        self.id = id
        self.name = name
        self.photo100 = photo100
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

//extension Group: Equatable {}



//struct AllGroups {
//    let name: String
//    let image: UIImage?
//}
//
//struct AllGroupsSections {
//    var title: String
//    var items: [AllGroups]
//
//}
//
//final class Groups {
//    static func makeGroups() -> [AllGroups] {
//        let gr1 = AllGroups(name: "111111", image: UIImage(named: "darth-vader"))
//        let gr2 = AllGroups(name: "Apple", image: UIImage(named: "darth-vader"))
//        let gr3 = AllGroups(name: "4ch", image: UIImage(named: "4ch"))
//        let gr4 = AllGroups(name: "lalalend", image: UIImage(named: "camera"))
//        return [gr1,gr2,gr3,gr4]
//    }
//}

