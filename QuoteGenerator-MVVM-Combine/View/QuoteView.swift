//
//  QuoteView.swift
//  MVVM-Combine-Quotes
//
//  Created by Ignacio Cervino on 31/03/2023.
//

import UIKit

class QuoteView: UIView {
    private lazy var stackView: UIStackView = {
        let VStackView = UIStackView()
        VStackView.axis = .vertical
        VStackView.alignment = .center
        VStackView.spacing = 24
        VStackView.distribution = .fillEqually
        VStackView.alignment = .fill
        return VStackView
    }()
    
    private lazy var quoteLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Default"
        return lbl
    }()
    
    private lazy var refreshBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        stackView.addArrangedSubview(quoteLbl)
        stackView.addArrangedSubview(refreshBtn)
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        quoteLbl.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            refreshBtn.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
