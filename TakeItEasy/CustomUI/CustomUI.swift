//
//  CustomUI.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/19/22.
//

import Foundation
import UIKit

func addBorderColor(_ x: inout UITextField) {
    x.layer.masksToBounds = true
    x.layer.borderColor = UIColor.gray.cgColor
    x.layer.borderWidth = 1.0
}
