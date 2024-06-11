//
//  LotteryViewController.swift
//  LayoutWithCode
//
//  Created by Jaka on 2024-06-10.
//

import UIKit
import Alamofire
import SnapKit

class LotteryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let searchField = UITextField()
    let numPicker = UIPickerView()
    let lottoDate = UILabel()
    let drawNum = UILabel()
    let numbersStack = UIStackView()
    let num1 = UILabel()
    let num2 = UILabel()
    let num3 = UILabel()
    let num4 = UILabel()
    let num5 = UILabel()
    let num6 = UILabel()
    let plusSign = UILabel()
    let bonusNum = UILabel()
    let bonusLabel = UILabel()
    
    lazy var numList = [num1, num2, num3, num4, num5, num6, plusSign, bonusNum]
    var drawNumList: [Int] = []
    var data: (String) = ""
    //let list = LottoDraw()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numPicker.dataSource = self
        numPicker.delegate = self
        print("self result: \(self)")
        
        configureHierarchy()
        configureSnap()
        callRequest(1000)
        configureView()
        
    }
    
    func configureHierarchy() {
        
        view.addSubview(searchField)
        view.addSubview(numPicker)
        view.addSubview(lottoDate)
        view.addSubview(drawNum)
        view.addSubview(numbersStack)
        for item in numList {
            numbersStack.addArrangedSubview(item)
        }
        view.addSubview(bonusLabel)
    }
    
    func configureSnap() {
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        numPicker.snp.makeConstraints { make in
            
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        lottoDate.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(20)
            make.left.equalTo(searchField)
        }
        drawNum.snp.makeConstraints { make in
            make.top.equalTo(lottoDate.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        numbersStack.snp.makeConstraints { make in
            make.top.equalTo(drawNum.snp.bottom).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        for num in numList {
            num.snp.makeConstraints { make in
                make.size.equalTo(36)
            }
        }
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(numbersStack.snp.bottom).offset(7)
            make.right.equalTo(bonusNum)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        for num in 1...1124 {
            drawNumList.append(num)
        }
        
        searchField.textAlignment = .center
        searchField.borderStyle = .roundedRect
        searchField.addTarget(self, action: #selector(searchFieldDidBeginEditing), for: .editingDidBegin)
        searchField.addTarget(self, action: #selector(searchFieldReturnClicked), for: .editingDidEndOnExit)
        
        numPicker.isHidden = true
        numPicker.backgroundColor = .lightGray
        
        lottoDate.textColor = .gray
        lottoDate.font = .systemFont(ofSize: 14)
        drawNum.font = .boldSystemFont(ofSize: 20)
        drawNum.textColor = .magenta
        
        numbersStack.axis = .horizontal
        numbersStack.spacing = 5
        
        for num in numList {
            if num == plusSign {
                num.text = "+"
                num.textColor = .black
                num.textAlignment = .center
            }
            else {
                num.textColor = .white
                num.textAlignment = .center
                num.backgroundColor = .systemTeal
                num.layer.cornerRadius = 18
                num.clipsToBounds = true
            }
        }
        
        bonusLabel.text = "보너스"
        bonusLabel.font = .systemFont(ofSize: 14)
    }
    
    @objc func searchFieldDidBeginEditing() {
        numPicker.isHidden = false
    }
    @objc func searchFieldReturnClicked() {
        callRequest(Int(searchField.text!) ?? 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drawNumList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(drawNumList[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchField.text = "\(drawNumList[row])"
        callRequest(drawNumList[row])
    }
    
    func callRequest(_ drawNum: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNum)"
        
        AF.request(url).responseDecodable(of: LottoDraw.self) { response in
                switch response.result {
                        
                case .success(let value):
                    self.drawNum.text = "\(drawNum)회 당첨결과"
                    self.lottoDate.text = "\(value.drwNoDate) 추첨"
                    self.num1.text = "\(value.drwtNo1)"
                    self.num2.text = "\(value.drwtNo2)"
                    self.num3.text = "\(value.drwtNo3)"
                    self.num4.text = "\(value.drwtNo4)"
                    self.num5.text = "\(value.drwtNo5)"
                    self.num6.text = "\(value.drwtNo6)"
                    self.bonusNum.text = "\(value.bnusNo)"
                    print("SUCCESS")
                    
                case .failure(let error):
                    print(error)
                    self.drawNum.text = "결과 없습니다"
                    self.lottoDate.text = ""
                    for num in self.numList {
                        if num.text != "+" {
                            num.text = "0"
                        }
                    }
                }
        }
    }
}
