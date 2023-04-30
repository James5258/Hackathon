//
//  Swift_prueba_HApp.swift
//  Swift prueba H
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI

@main
struct Swift_prueba_HApp: App {
    
    @StateObject private var dataController = DataControllerDB()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                                              dataController.container.viewContext)
        }
    }
}
