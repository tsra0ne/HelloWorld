//
//  NavigationController.swift
//  HelloWorld
//
//  Created by Sravan Goud on 18/03/26.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
