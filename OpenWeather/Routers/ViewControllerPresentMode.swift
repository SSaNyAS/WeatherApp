//
//  ViewControllerPresentMode.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 25.08.2022.
//

import Foundation
import UIKit

enum ViewControllerPresentMode{
    case present
    case push
    case modal
    case custom(UIModalPresentationStyle, UIModalTransitionStyle)
}
