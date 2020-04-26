//
//  IMAlert.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/26/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

struct IMAlert {
    
    static func showAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
}
