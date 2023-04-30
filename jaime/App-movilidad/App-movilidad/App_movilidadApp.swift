//
//  App_movilidadApp.swift
//  App-movilidad
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI

@main
struct App_movilidadApp: App {
    
    @StateObject private var dataController = DataControllerDB()
    
    var body: some Scene {
        WindowGroup {
            vista1()
                .environment(\.managedObjectContext,dataController.container.viewContext)
        }
    }
}
