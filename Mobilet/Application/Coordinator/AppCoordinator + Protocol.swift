//
//  AppCoordinator + Protocol.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation

/// The `Coordinator` protocol defines the common interface for coordinators, which are responsible for
/// managing navigation and flow control within an application.
protocol Coordinator: AnyObject {
    /// Starts the coordinator's tasks or navigation flow.
    func start()
}
