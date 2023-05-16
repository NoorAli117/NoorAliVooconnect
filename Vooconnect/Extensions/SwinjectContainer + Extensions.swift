//
//  SwinjectContainer + Extension.swift
//  LiveCheff
//
//  Created by Online Developer on 20/02/2023.
//

import Foundation
import Swinject

extension Container {
    enum `default` {
        static let container: Container = {
            Container()
        }()
        static let resolver: Resolver = {
            container.synchronize()
        }()
    }
}
