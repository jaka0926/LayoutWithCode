//
//  BoxOfficeTableViewController.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-12.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: UIViewController {
        
    let searchField = UISearchTextField()
    let searchButton = UIButton()
    let tableView = UITableView()
    var list = BoxOfficeAPI(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: []))
    var numbering = 0
    
    struct BoxOfficeAPI: Decodable {
        let boxOfficeResult: BoxOfficeResult
    }
    
    struct BoxOfficeResult: Decodable{
        let dailyBoxOfficeList: [DailyBoxOfficeList]
    }
    
    struct DailyBoxOfficeList: Decodable {
        let movieNm: String
        let openDt: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
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
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.backgroundColor = .darkGray
        

        searchField.text = "20240611"
        searchField.borderStyle = .none
        searchField.textColor = .white
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.white.cgColor
        searchField.addTarget(self, action: #selector(searchButtonClicked), for: .editingDidEndOnExit)
        searchField.attributedPlaceholder = NSAttributedString(string: "날짜 입력하세요. 예: 202406011", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        searchButton.backgroundColor = .white
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.setTitle("검색", for: .normal)
        searchButton.titleLabel?.textAlignment = .center
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .none
        tableView.rowHeight = 60
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
    }
    
    @objc func searchButtonClicked() {
        numbering = 0
        callRequest(searchField.text ?? "20240611")
        view.endEditing(true)
    }
    
    
    func callRequest(_ date: String) {
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.moviePortal)&targetDt=\(date)"
        
        AF.request(url, method: .get).responseDecodable(of: BoxOfficeAPI.self) { response in
            
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.list = value
                self.tableView.reloadData()
            case .failure(let error):
                print("FAILURE", error)
            }
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.boxOfficeResult.dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as! BoxOfficeTableViewCell

        let data = list.boxOfficeResult.dailyBoxOfficeList[indexPath.row]
        print("data: ", data)
        
        numbering += 1
        cell.numberLabel.text = "\(numbering)"
        cell.movieTitle.text = data.movieNm
        cell.movieReleaseDate.text = data.openDt
        
        return cell
        
    }
}
