//
//  BoxOfficeTableViewCell.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-12.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {

    let numberLabel = UILabel()
    let movieTitle = UILabel()
    let movieReleaseDate = UILabel()
    static let id = "BoxOfficeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieReleaseDate)
        
        configureLayout()

        contentView.backgroundColor = .black
        numberLabel.textColor = .black
        numberLabel.backgroundColor = .white
        numberLabel.textAlignment = .center
        
        movieTitle.textColor = .white
        movieTitle.font = .boldSystemFont(ofSize: 18)
        movieTitle.numberOfLines = 2

        movieReleaseDate.textColor = .white
        movieReleaseDate.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        
        numberLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(210)
        }
        
        movieReleaseDate.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(movieTitle.snp.right).offset(15)
        }
    }
}
