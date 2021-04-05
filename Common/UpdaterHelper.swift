//
//  UpdaterHelper.swift
//  CalMenu
//
//  Created by Fernando Crespo on 05/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import Foundation
import Sparkle

func checkForUpdates() {
    let updater: SUUpdater = SUUpdater()
    updater.checkForUpdates(nil)
}
