//
//  ContentView.swift
//  Shared
//
//  Created by Michele Manniello on 28/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
         HomeView()
            .navigationTitle("Medium")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
