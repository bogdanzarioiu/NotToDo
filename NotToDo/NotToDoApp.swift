//
//  NotToDoApp.swift
//  NotToDo
//
//  Created by Bogdan on 2/13/21.
//


import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct NotToDoApp: App {
    
    init() {
        configureAmplify()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            print("Amplify configured.")
            
        } catch {
            print("Could not configure Amplify: \(error)")
        }
        
    }
}
