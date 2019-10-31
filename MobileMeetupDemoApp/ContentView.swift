//
//  ContentView.swift
//  MobileMeetupDemoApp
//
//  Created by Lukas Gergel on 30/10/2019.
//  Copyright © 2019 Zonky a.s. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let userManager: UserManaging?
    
    init(userManager: UserManaging? = nil) {
        self.userManager = userManager
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Hello meetup!")
            
            Spacer()
            
            Button(action: { self.userManager?.login.apply().start() }) {
                Text("Login")
            }
            
            Spacer()
            
            Button(action: { self.userManager?.fetchMe.apply().start() }) {
                Text("Fetch me")
            }
            
            Spacer()
            
            Button(action: { self.userManager?.logout.apply().start() }) {
                Text("Logout")
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
