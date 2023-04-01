//
//  ViewModelBindable.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 01/04/2023.
//

import Foundation

/// Protocol defined to be used by UIViewControllers and UIViews that need to be bindable to a view model and vice-versa.
protocol ViewModelBindable {
    /// Use this function when your view properties needs to be binded to a viewModel property
    func bindViewToViewModel()
    /// Use this function when you need to bind a property from your view model to your view
    func bindViewModelToView()
}

// Default implementations so each can be optional
extension ViewModelBindable {
    func bindViewToViewModel() {}
    func bindViewModelToView() {}
}
