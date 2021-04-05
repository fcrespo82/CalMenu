//
//  Constants.swift
//  CalMenu
//
//  Created by Fernando Crespo on 04/04/21.
//  Copyright © 2021 Fernando Crespo. All rights reserved.
//

import Foundation

let LAUNCHER_APP_IDENTIFIER = "br.com.crespo.CalMenu.Launcher"
let MAIN_APP_IDENTIFIER = "br.com.crespo.CalMenu"
let KILL_LAUNCHER_NOTIFICATION_NAME = "br.com.crespo.CalMenu.killLauncher"
let DEFAULTS_LAUNCH_ON_BOOT_KEY = "launchOnStartUp"
let DEFAULTS_CHECK_FOR_UPDATE_KEY = "SUEnableAutomaticChecks"

extension Notification.Name {
    static let killLauncher = Notification.Name(KILL_LAUNCHER_NOTIFICATION_NAME)
}
