//
//  ViewConfigurable.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation

/// A protocol defined for UIViewControllers and UIViews that use UI programatically
protocol ViewConfigurable {
    /// Use this function to add all your custom subviews
    func buildViewHierarchy()
    
    func setupConstraints()
    
    /// Use this function to setup the actionable targets of each subview if needed
    func setupTargets()
    
    /// Use this function to setup the button tap publishers of each subview if needed
    func observeButtonTaps()
}

/// Default implementation
extension ViewConfigurable {
    func configureView() {
        buildViewHierarchy()
        setupConstraints()
        setupTargets()
        observeButtonTaps()
    }
    func buildViewHierarchy() {}
    func setupConstraints() {}
    func setupTargets() {}
    func observeButtonTaps() {}
}
