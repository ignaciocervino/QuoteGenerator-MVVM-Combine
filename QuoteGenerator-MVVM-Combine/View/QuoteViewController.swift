//
//  ViewController.swift
//  MVVM-Combine-Quotes
//
//  Created by Ignacio Cervino on 31/03/2023.
//

import UIKit

final class QuoteViewController: UIViewController {
    
    private let quoteView: QuoteView
    
    init(quoteView: QuoteView) {
        self.quoteView = quoteView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = quoteView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTargets()
    }
}

extension QuoteViewController: ViewModelBindable {
    
}

extension QuoteViewController: ViewConfigurable {
    
    func setupConstraints() {
        quoteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quoteView.topAnchor.constraint(equalTo: view.topAnchor),
            quoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTargets() {
        quoteView.refreshBtn.addTarget(self, action: #selector(refreshClick), for: .touchUpInside)
    }
}

// MARK: - Targets
private extension QuoteViewController {
    @objc func refreshClick() {
        //viewModel.refreshClick()
    }
}

