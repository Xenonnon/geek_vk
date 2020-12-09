//
//  ViewController.swift
//  WeatherGB
//
//  Created by Евгений Дербенев on 30.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {}

    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       guard checkUser() else {
           showAlert()
           return false
       }
       return true
    }
    
    internal func checkUser() -> Bool {
        guard
            let username = loginText.text,
            let password = passwordText.text
        else { return false }
        return username == "1" && password == "1"
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Incorrect username or password",
            preferredStyle: .alert)
        let alertItem = UIAlertAction(
            title: "Ok:(",
            style: .cancel)
        { _ in
            self.loginText.text = ""
            self.passwordText.text = ""
        }
        alertController.addAction(alertItem)
        present(alertController,
                animated: true,
                completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    



}

    
