//
//  SceneDelegate.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = makeRootViewController()
		window?.makeKeyAndVisible()
	}
	
	private func makeRootViewController() -> UIViewController {
		let tabBar = UITabBarController()
		tabBar.viewControllers = [singleSelectionVC(), rangeSelectionVC()]
		return tabBar
	}

	private func singleSelectionVC() -> UIViewController {
		let nav = UINavigationController(rootViewController: SingleSelectionCalendarViewController())
		nav.tabBarItem.title = "Single"
		return nav
	}
	
	private func rangeSelectionVC() -> UIViewController {
		let nav = UINavigationController(rootViewController: RangeSelectionCalendarViewController())
		nav.tabBarItem.title = "Range"
		return nav
	}
}

