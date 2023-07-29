//
//  SceneDelegate.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CurrentWeatherViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
