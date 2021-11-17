//
//  SignUpViewController.swift
//  WeSports
//
//  Created by datNguyem on 16/11/2021.
//

import UIKit

final class SignUpViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var registerContainer: UIView!
    @IBOutlet private weak var textFieldsContainer: InforTextFields!
    @IBOutlet private weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    
    private func setupView() {
        view.layoutIfNeeded()
        activeHandleKeyboard()
        scrollView.isScrollEnabled = false
        scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: false)
        
        registerButton.makeRadius(radius: 10)
        scrollView.makeRadius(radius: 25,
                              mask: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        textFieldsContainer.nameCustomTextField.textField.tag = 1
        textFieldsContainer.usernameCustomTextField.textField.tag = 2
        textFieldsContainer.phoneCustomTextField.textField.tag = 3
    }
    
    private func setupAction() {
        registerContainer.addGestureRecognizer(UITapGestureRecognizer(
                                                target: self, action: #selector(turnOffKeyBoard)))
        textFieldsContainer.nameCustomTextField.textField.addTarget(
            self,
            action: #selector(scrollToPosition(sender:)), for: .editingDidBegin)
        textFieldsContainer.usernameCustomTextField.textField.addTarget(
            self,
            action: #selector(scrollToPosition(sender:)), for: .editingDidBegin)
        textFieldsContainer.phoneCustomTextField.textField.addTarget(
            self,
            action: #selector(scrollToPosition(sender:)), for: .editingDidBegin)
    }
    
    @objc
    func scrollToPosition(sender: UITextField) {
        switch sender.tag {
        case 1:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: 0, y: 130), animated: true)
        case 3:
            scrollView.setContentOffset(CGPoint(x: 0, y: 230), animated: true)
        default:
            break
        }
    }
    
    @IBAction func registerDidTapped(_ sender: Any) {
        
    }
}

extension SignUpViewController {
    func activeHandleKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                    as? NSValue)?.cgRectValue
        else {
            return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
        scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        scrollView.isScrollEnabled = false
        scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: false)
    }
}
