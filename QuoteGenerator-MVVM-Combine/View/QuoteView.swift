//
//  QuoteView.swift
//  MVVM-Combine-Quotes
//
//  Created by Ignacio Cervino on 31/03/2023.
//

import UIKit

protocol QuoteViewProtocol {
    var quoteLbl: UILabel { get }
    var refreshBtn: UIButton { get }
}

class QuoteView: UIView, QuoteViewProtocol {
    // MARK: Properties
    private lazy var stackView: UIStackView = {
        let VStackView = UIStackView()
        VStackView.axis = .vertical
        VStackView.spacing = 24
        VStackView.alignment = .fill
        return VStackView
    }()
    
    private(set) lazy var quoteLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Default"
        return lbl
    }()
    
    private(set) lazy var refreshBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    // MARK: Initializer
    convenience init() {
        self.init(frame: .zero)
        buildViewHierarchy()
        setupConstraints()
    }
}

// MARK: View Configurable
extension QuoteView: ViewConfigurable {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(quoteLbl)
        stackView.addArrangedSubview(refreshBtn)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            refreshBtn.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
