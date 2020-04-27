//
//  UIViewController+Extensions.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/27/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showEmptyStates(message: String, inView view: UIView) {
        let emptyStateView = IMEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
