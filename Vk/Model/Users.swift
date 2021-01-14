//
//  Users.swift
//  Vk
//
//  Created by Евгений Дербенев on 28.12.2020.
//

import UIKit

struct MyFriendsSections {
    var title: String
    var items: [Users]
}

struct Users {
    let userName: String
    let userAvatar: UIImage?
    let userImages: [UIImage?]
}

final class Friends {
    static func makeFriends() -> [Users] {
        let fr1 = Users(userName: "1111", userAvatar: UIImage(named: "camera"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr2 = Users(userName: "Илон Маск", userAvatar: UIImage(named: "darth-vader"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr3 = Users(userName: "Всемогущий я", userAvatar: UIImage(named: "4ch"), userImages: [UIImage(named: "bluelike"),UIImage(named: "bluelike"),UIImage(named: "heart")])
        let fr4 = Users(userName: "И прочие", userAvatar: UIImage(named: "darth-vader"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr5 = Users(userName: "АННА", userAvatar: UIImage(named: "camera"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr6 = Users(userName: "Энакин", userAvatar: UIImage(named: "darth-vader"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr7 = Users(userName: "Сидиус", userAvatar: UIImage(named: "darth-vader"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "darth-vader"),UIImage(named: "darth-vader")])
        let fr8 = Users(userName: "Кто-то другой", userAvatar: UIImage(named: "bluelike"), userImages: [UIImage(named: "darth-vader"),UIImage(named: "heart"),UIImage(named: "darth-vader")])
        
        return [fr1,fr2,fr3,fr4,fr5,fr6,fr7,fr8]
    }
}
