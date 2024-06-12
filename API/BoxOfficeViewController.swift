//
//  BoxOfficeTableViewController.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-12.
//

import UIKit
import SnapKit

class BoxOfficeViewController: UIViewController {
        
    let searchField = UISearchTextField()
    let searchButton = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(searchField)
        view.addSubview(searchButton)
        
        searchField.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(280)
            make.height.equalTo(40)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(searchField.snp.right).offset(15)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(searchField)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.backgroundColor = .darkGray
        searchField.borderStyle = .none
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.white.cgColor
        
        searchButton.backgroundColor = .white
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.setTitle("검색", for: .normal)
        searchButton.titleLabel?.textAlignment = .center
        
        tableView.backgroundColor = .cyan
    }

}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as! BoxOfficeTableViewCell
        
        return cell
        
    }
    
    
}
