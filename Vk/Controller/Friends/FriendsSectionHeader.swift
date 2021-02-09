//
//  FriendsSectionHeader.swift
//  Vk
//
//  Created by Евгений Дербенев on 2/2/21.
//

import UIKit

class FriendsSectionHeader: UITableViewHeaderFooterView {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
}
