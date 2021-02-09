//
//  UITableView+Ext.swift
//  Vk
//
//  Created by Евгений Дербенев on 2/9/21.
//

import UIKit

extension UITableView {
    func update(deletions: [Int],
                insertions: [Int],
                modifications: [Int],
                sections: Int = 0) {
        self.beginUpdates()
        deleteRows(at: deletions.map { IndexPath(row: $0,
                                                 section: sections)},
                   with: .automatic)
        insertRows(at: insertions.map { IndexPath(row: $0,
                                                  section: sections) },
                   with: .automatic)
        reloadRows(at: modifications.map { IndexPath(row: $0,
                                                     section: sections) },
                   with: .automatic)
        self.endUpdates()
    }
}
