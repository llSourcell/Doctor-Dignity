//
//  Fonts.swift
//  MLCChat
//
//  Created by Roma iOS on 12.09.2023.
//

import Foundation
import SwiftUI

struct Fonts {

    static let welcomeFont: Font = UIDevice.isIPad ? Font.system(size: UIScreen.width * 0.03) : Font.system(size: UIScreen.width * 0.04)

    static let welcomeFontMinimized: Font = UIDevice.isIPad ? Font.system(size: UIScreen.width * 0.02) : Font.system(size: UIScreen.width * 0.03)
}
