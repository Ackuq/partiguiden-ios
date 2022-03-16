//
//  UIColor.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-15.
//

import Foundation
import UIKit

extension UIColor {

    public func adjust(hueBy hue: CGFloat = 0, saturationBy saturation: CGFloat = 0, brightnessBy brightness: CGFloat = 0) -> UIColor {

        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0

        if getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha) {
            return UIColor(hue: currentHue + hue,
                       saturation: currentSaturation + saturation,
                       brightness: currentBrigthness + brightness,
                       alpha: currentAlpha)
        } else {
            return self
        }
    }
}
