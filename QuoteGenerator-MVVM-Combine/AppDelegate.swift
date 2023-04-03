//
//  AppDelegate.swift
//  QuoteGenerator-MVVM-Combine
//
//  Created by Ignacio Cervino on 31/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let quoteView = QuoteView()
        let quoteViewModel = QuoteViewModel()
        let quoteVC = QuoteViewController(quoteView: quoteView, viewModel: quoteViewModel)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = quoteVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
