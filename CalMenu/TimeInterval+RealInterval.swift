//
//  TimeInterval+RealDates.swift
//  CalMenu
//
//  Created by Fernando Crespo on 21/08/20.
//  Copyright © 2020 Fernando Crespo. All rights reserved.
//

import Foundation

extension TimeInterval {
    static var ondeDay: TimeInterval {
        return TimeInterval(1 * 60 * 60 * 24)
    }

    static var oneMonth: TimeInterval {
        return TimeInterval(1 * 60 * 60 * 24 * 30)
    }

    static var oneYear: TimeInterval {
        return TimeInterval(1 * 60 * 60 * 24 * 365)
    }
}
