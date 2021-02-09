//
//  UIViewController+Ext.swift
//  Vk
//
//  Created by Евгений Дербенев on 2/9/21.
//

import UIKit

extension UIViewController {
    func show(error: Error) {
        let alertVC = UIAlertController(title: "Ошибка",
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK",
                                     style: .default)
        alertVC.addAction(okButton)
        present(alertVC, animated: true)
    }
}
