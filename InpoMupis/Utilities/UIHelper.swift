//
//  UIHelper.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createTwoColumnsFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                       = view.bounds.width
        let padding: CGFloat            = 20
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 2
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth * 1.48)
        
        
        return flowLayout
        
    }
    
}
