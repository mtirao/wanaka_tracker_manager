//
//  RouterHandler.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation
import SwiftUI

// Contains the possible destinations in our Router
enum Route: Hashable {
    case newApp
}


protocol RouteHandler: ObservableObject {
    associatedtype T: View
    
    var path: NavigationPath { get }
    
    @MainActor func view(for route: Route) -> T
    func navigateTo(_ appRoute: Route)
    func navigateBack()
    func popToRoot()
}

extension RouteHandler {
    @ViewBuilder
    func view(for route: Route) -> some View {
        EmptyView()
    }
}

@Observable
class ViewRouter: RouteHandler {
    // Used to programatically control our navigation stack
    var path: NavigationPath = NavigationPath()
    
    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
    
}
