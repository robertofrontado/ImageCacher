//
//  Mocks.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation
import UIKit

class Mocks {

    static let url = URL(string: "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png")!
    static let image = UIImage(named: "grumpy-cat", in: Bundle(for: Mocks.self), compatibleWith: nil)!
}
