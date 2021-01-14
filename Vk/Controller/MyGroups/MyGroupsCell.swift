//
//  MyGroupsCell.swift
//  Vk
//
//  Created by Евгений Дербенев on 14.12.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    @IBOutlet weak var myGroupName: UILabel!
    @IBOutlet weak var myGroupImage: UIImageView!
    @IBOutlet weak var groupImageView: ImageModTwo!
    @IBAction func avatarAnimate(_ sender: UIButton) {
        sender.avaAnimation(avatarAnimation: groupImageView)
    }
    
}
