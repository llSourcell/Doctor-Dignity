//
//  UIScreenExtension.swift
//  MLCChat
//
//  Created by Roma iOS on 12.09.2023.
//

import UIKit

extension UIScreen {

    static var size: CGSize {
        return UIScreen.main.bounds.size
    }

    static var width: CGFloat {
        return size.width
    }

    static var height: CGFloat {
        return size.height
    }
}
