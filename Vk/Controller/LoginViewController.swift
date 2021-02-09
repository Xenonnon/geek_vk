//
//  ViewController.swift
//  Vk
//
//  Created by Евгений Дербенев on 30.11.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var firstDot: UIView!
    @IBOutlet weak var secondDot: UIView!
    @IBOutlet weak var thirdDot: UIView!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {}
    var count = 0
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        animateDots()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if self.checkUser() {
                self.performSegue(withIdentifier: "MainSegue", sender: nil)
            } else {
                self.showAlert()
            }
        }
    }
    
    internal func checkUser() -> Bool {
        guard
            let username = loginText.text,
            let password = passwordText.text
        else { return false }
        return username == "" && password == ""
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
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        count = 0
        firstDot.layer.cornerRadius = firstDot.bounds.height / 2
        secondDot.layer.cornerRadius = secondDot.bounds.height / 2
        thirdDot.layer.cornerRadius = thirdDot.bounds.height / 2
        firstDot.backgroundColor = .clear
        secondDot.backgroundColor = .clear
        thirdDot.backgroundColor = .clear
        animateAppearing()
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        firstDot.backgroundColor = .clear
        secondDot.backgroundColor = .clear
        thirdDot.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    func animateDots() {
        UIView.animate(withDuration: 0.5, animations: {
            self.firstDot.backgroundColor = .white
            self.firstDot.alpha = 0
        }) { _ in
            self.firstDot.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                self.secondDot.backgroundColor = .white
                self.secondDot.alpha = 0
            }) { _ in
                self.secondDot.alpha = 1
                UIView.animate(withDuration: 0.5, animations: {
                    self.thirdDot.backgroundColor = .white
                    self.thirdDot.alpha = 0
                }) { _ in
                    self.thirdDot.alpha = 1
                    if self.count < 3 {
                        self.count += 1
                        self.animateDots()
                    }
                }
            }
        }
    }
    
    
    func animateAppearing() {
        self.loginText.transform = CGAffineTransform(translationX: -self.view.bounds.height / 2, y: 0)
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: { self.loginText.transform = .identity
            //self.loginLabel.transform = .identity
        }, completion: nil)
        
        self.passwordText.transform = CGAffineTransform(translationX: self.view.bounds.height / 2, y: 0)
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: { self.passwordText.transform = .identity
        }, completion: nil)
        
        loginButton.transform = CGAffineTransform(translationX: 0, y: 300)
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: { self.loginButton.transform = .identity
        }, completion: nil)
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.stiffness = 350
        animation.duration = 1.0
    }
}

    
