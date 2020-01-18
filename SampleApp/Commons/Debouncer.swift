//
//  Debouncer.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

class Debouncer {

    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let interval: TimeInterval

    init(interval: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.interval = interval
        self.queue = queue
    }

    func debounce(_ block: @escaping () -> Void) {
        workItem?.cancel()
        let workItem = DispatchWorkItem() { block() }
        queue.asyncAfter(deadline: .now() + Double(interval), execute: workItem)
        self.workItem = workItem
    }
}
