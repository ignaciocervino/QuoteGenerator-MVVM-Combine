//
//  ViewController.swift
//  MVVM-Combine-Quotes
//
//  Created by Ignacio Cervino on 31/03/2023.
//

import UIKit
import Combine

final class QuoteViewController: UIViewController {
    // MARK: Properties
    let quoteView: QuoteViewProtocol
    let viewModel: QuoteViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Initializer
    init(quoteView: QuoteViewProtocol, viewModel: QuoteViewModelProtocol) {
        self.quoteView = quoteView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Functions
    override func loadView() {
        view = quoteView as? UIView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTargets()
        bindViewModelToView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
}

// MARK: - ViewModelBindable
extension QuoteViewController: ViewModelBindable {
    func bindViewModelToView() {
        viewModel.quoteResultPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.quoteView.quoteLbl.text = "Unknown"
                    assertionFailure(error.localizedDescription)
                }
            }, receiveValue: { [unowned self] quote in
                self.quoteView.quoteLbl.text = quote.content
            })
            .store(in: &cancellables)
        
        viewModel.toggleRefreshButtonPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: quoteView.refreshBtn)
            .store(in: &cancellables)
    }
}

// MARK: - ViewConfigurable
extension QuoteViewController: ViewConfigurable {
    
    func setupConstraints() {
        guard let quoteView = quoteView as? UIView else {
            fatalError("quoteView is not a UIView")
        }
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
        viewModel.refreshButtonSelected()
    }
}
