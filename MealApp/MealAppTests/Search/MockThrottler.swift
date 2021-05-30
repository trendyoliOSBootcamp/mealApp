//
//  MockThrottler.swift
//  MealAppTests
//
//  Created by Yusuf Özgül on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockThrottler: ThrottlerInterface {
    var invokedThrottler = false
    func throttle(_ block: @escaping () -> Void) {
        invokedThrottler = true
        block()
    }
}
