//
//  SignUpViewController.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-08.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    let titleLabel = UILabel()
    let textFieldStack = UIStackView()
    let emailField = UITextField()
    let passwordField = UITextField()
    let nicknameField = UITextField()
    let locationField = UITextField()
    let referralField = UITextField()
    let registerButton = UIButton()
    let subtitleLabel = UILabel()
    let switchButton = UISwitch()
    let tapGesture = UITapGestureRecognizer()
    
    lazy var stackList = [emailField: "이메일",
                          passwordField: "비밀번호",
                          nicknameField: "닉네임",
                          locationField: "위치",
                          referralField: "추천인 코드"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureSnap()
        configureUI()
    }
    
    func configureHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(textFieldStack)
            textFieldStack.addArrangedSubview(emailField)
            textFieldStack.addArrangedSubview(passwordField)
            textFieldStack.addArrangedSubview(nicknameField)
            textFieldStack.addArrangedSubview(locationField)
            textFieldStack.addArrangedSubview(referralField)
            textFieldStack.addArrangedSubview(registerButton)
        view.addGestureRecognizer(tapGesture)
        view.addSubview(subtitleLabel)
        view.addSubview(switchButton)
    }
    
    func configureSnap() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        textFieldStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        for (key, value) in stackList {
            key.snp.makeConstraints { make in
                make.width.equalTo(300)
                make.height.equalTo(35)
            }
        }
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(textFieldStack)
            make.center.equalTo(switchButton.snp.center)
        }
        switchButton.snp.makeConstraints { make in
            make.right.equalTo(textFieldStack)
            make.top.equalTo(textFieldStack.snp.bottom).offset(20)
        }
        
    }
    
    func configureUI() {
        
        view.backgroundColor = .black
        
        tapGesture.addTarget(self, action: #selector(keyboardDismiss))
        
        titleLabel.text = "NETFLIX"
        titleLabel.textColor = .red
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 15
        
        for (key, value) in stackList {
            key.attributedPlaceholder = NSAttributedString(string: value, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            key.backgroundColor = .darkGray
            key.layer.cornerRadius = 5
            key.textAlignment = .center
            key.textColor = .white
            key.keyboardType = switch key {
                               case emailField: .emailAddress
                               case referralField: .numberPad
                               default: .default
                               }
            if key == passwordField {
                key.isSecureTextEntry = true
            }
        }
        
        registerButton.setTitle("회원가입", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .white
        registerButton.layer.cornerRadius = 5
        
        subtitleLabel.text = "로그인 상태 유지"
        subtitleLabel.textColor = .white
        
        switchButton.isOn = true
        switchButton.onTintColor = .red
    }
    
    @objc func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
