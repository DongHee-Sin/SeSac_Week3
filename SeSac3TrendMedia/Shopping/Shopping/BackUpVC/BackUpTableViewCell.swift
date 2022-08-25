//
//  BackUpTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/25.
//

import UIKit
import SnapKit

class BackUpTableViewCell: UITableViewCell {

    // MARK: - Propertys
    let fileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "newspaper")
        view.tintColor = .darkGray
        return view
    }()
    
    lazy var labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        [titleLabel, sizeLabel].forEach {
            view.addArrangedSubview($0)
        }
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.text = "TEST TEXT"
        return view
    }()
    
    let sizeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.text = "TEST TEXT"
        return view
    }()
    
    
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    // MARK: - Methods
    func configureUI() {
        [fileImageView, labelStackView].forEach {
            self.addSubview($0)
        }
        
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }
    
    
    func setConstraints() {
        fileImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(8)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(fileImageView.snp.height)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(fileImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).offset(-12)
        }
    }
    
    
    func updateCell(backupFileURL url: URL, size: String) {
        titleLabel.text = url.lastPathComponent
        sizeLabel.text = size
    }
}

