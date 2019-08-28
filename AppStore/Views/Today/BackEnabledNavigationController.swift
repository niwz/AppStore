//
//  BackEnabledNavigationController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/27/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
