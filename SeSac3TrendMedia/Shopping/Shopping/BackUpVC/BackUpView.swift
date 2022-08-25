//
//  BackUpView.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/25.
//

import UIKit
import SnapKit

class BackUpView: UIView {
    
    // MARK: - Propertys
    lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        [backupButton, restoreButton].forEach {
            view.addArrangedSubview($0)
        }
        return view
    }()
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업하기", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        view.titleLabel?.textColor = .white
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let restoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업하기", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        view.titleLabel?.textColor = .white
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backupListTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraint()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    // MARK: - Methods
    func configureUI() {
        [buttonStackView, backupListTableView].forEach {
            self.addSubview($0)
        }
    }
    
    
    func setConstraint() {
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(70)
        }
        
        backupListTableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
