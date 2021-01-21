//
//  FriendsCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 24.12.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    @IBAction func LogOut(_ sender: Any) {
    }
    
    @IBOutlet weak var friendImageView: ImageModTwo!
    @IBAction func avatarAnimate(_ sender: UIButton) {
        sender.avaAnimation(avatarAnimation: friendImageView)
        
    }
}
