//
//  ContentView.swift
//  Shared
//
//  Created by Alejandro Figueroa on 5/7/22.
//

import SwiftUI

struct Settings {
    var read = false
    var write = false
    var execute = false
}

struct UserClass {
    let title: String
    var settings = Settings()
    
    init(_ t: String) {
        title = t
    }
}

func makeOctal(_ o: Settings, _ g: Settings, _ e: Settings) -> String {
    return [o,g,e].reduce("") {
        $0 + String(($1.read ? 4 : 0) + ($1.write ? 2 : 0) + ($1.execute ? 1 : 0))
    }
}

func makeSymbol(_ o: Settings, _ g: Settings, _ e: Settings) -> String {
    return [o,g,e].reduce("") {
        $0 + ($1.read ? "r" : "-") + ($1.write ? "w" : "-") + ($1.execute ? "x" : "-")
    }
}


struct UserClassView: View {
    @Binding var userClass: UserClass
    
    var body: some View {
        VStack {
            Text(userClass.title)
                .font(.title)
            VStack {
                Toggle("Read", isOn: $userClass.settings.read)
                Toggle("Write", isOn: $userClass.settings.write)
                Toggle("Execute", isOn: $userClass.settings.execute)
            }
        }
    }
}

struct ContentView: View {
    @State private var owner = UserClass("Owner")
    @State private var group = UserClass("Group")
    @State private var everyone = UserClass("Everyone")
    
    var body: some View {
        VStack {
            let _ = print(owner)
            HStack {
                UserClassView(userClass: $owner)
                UserClassView(userClass: $group)
                UserClassView(userClass: $everyone)
            }
            
            HStack {
                Text(makeOctal(owner.settings, group.settings, everyone.settings))
                Text(makeSymbol(owner.settings, group.settings, everyone.settings))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
