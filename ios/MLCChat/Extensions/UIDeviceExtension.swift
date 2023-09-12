//
//  UIDeviceExtension.swift
//  MLCChat
//
//  Created by Roma iOS on 12.09.2023.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
