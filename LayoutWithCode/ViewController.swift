//
//  ViewController.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-04.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let posterView = UIView()
        let posterImage = UIImageView()
        let posterLabel = UILabel()
        let buttonStack = UIStackView()
        let playButton = UIButton()
        let addtolistButton = UIButton()
    let gridView = UIView()
        let gridLabel = UILabel()
        let imageStack = UIStackView()
        let image1 = UIImageView()
        let image2 = UIImageView()
        let image3 = UIImageView()
    
    lazy var imageList = [posterImage, image1, image2, image3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureSnap()
        configureUI()
        
        view.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "자카님"
        
        // Create a UIBarButtonItem with a title
        let signupButton = UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(signupButtonClicked))
                
        // Set the button to the right side of the navigation bar
        navigationItem.rightBarButtonItem = signupButton
        
    }
    
    @objc func signupButtonClicked() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func configureHierarchy() {
        view.addSubview(posterView)
            posterView.addSubview(posterImage)
            posterView.addSubview(posterLabel)
            posterView.addSubview(buttonStack)
                buttonStack.addArrangedSubview(playButton)
                buttonStack.addArrangedSubview(addtolistButton)
        
        view.addSubview(gridView)
            gridView.addSubview(gridLabel)
            gridView.addSubview(imageStack)
                imageStack.addArrangedSubview(image1)
                imageStack.addArrangedSubview(image2)
                imageStack.addArrangedSubview(image3)
    }
    
    func configureUI() {
        
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20
        
        playButton.setBackgroundImage(UIImage(named: "play_normal"), for: .normal)
        playButton.setBackgroundImage(UIImage(named: "play_highlighted"), for: .highlighted)
        playButton.layer.cornerRadius = 5
        
        addtolistButton.backgroundColor = .darkGray
        addtolistButton.tintColor = .white
        addtolistButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addtolistButton.setTitle(" 내가 찜한 리스트", for: .normal)
        addtolistButton.layer.cornerRadius = 5
        
        gridLabel.text = "지금 뜨는 콘텐츠"
        gridLabel.textColor = .white
        
        //imageStack.backgroundColor = .green
        imageStack.axis = .horizontal
        imageStack.distribution = .fillEqually
        imageStack.spacing = 10
        
        for img in imageList {
            img.image = UIImage(named: "스즈메의문단속")
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            img.layer.cornerRadius = 10
        }
    }
    
    func configureSnap() {
        posterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(250)
        }
        
        gridView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(posterView.snp.bottom)
        }
        
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttonStack.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(15)
            make.height.equalTo(35)
        }
        
        imageStack.snp.makeConstraints { make in
            make.top.equalTo(gridView.snp.top).offset(35)
            make.horizontalEdges.equalToSuperview()
        }
        
        gridLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalTo(imageStack.snp.top).offset(-5)
        }
        
        image1.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
}

