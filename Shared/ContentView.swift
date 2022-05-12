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

struct UserClassSettingView: View {
    var label: String
    @Binding var val: Bool
    
    var body: some View {
        Toggle(isOn: $val) {
            Text(label)
                .scaledToFill()
                .frame(maxWidth: .infinity)
        }.toggleStyle(.button)
    }
}

struct UserClassView: View {
    @Binding var userClass: UserClass
    
    var body: some View {
        VStack() {
            Text(userClass.title)
                .font(.title)
                .multilineTextAlignment(.leading)
            VStack {
                UserClassSettingView(label: "Read", val: $userClass.settings.read)
                UserClassSettingView(label: "Write", val: $userClass.settings.write)
                UserClassSettingView(label: "Execute", val: $userClass.settings.execute)
            }
        }
    }
}

struct ContentView: View {
    @State private var owner = UserClass("Owner")
    @State private var group = UserClass("Group")
    @State private var everyone = UserClass("Public")
    
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
    
    var Main: some View {
        VStack() {
            
            HStack {
                Text(makeOctal(owner.settings, group.settings, everyone.settings))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.392, opacity: 0.549))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                Text(makeSymbol(owner.settings, group.settings, everyone.settings))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.392, opacity: 0.549))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            Spacer()
            HStack() {
                UserClassView(userClass: $owner)
                UserClassView(userClass: $group)
                UserClassView(userClass: $everyone)
            }.padding(.bottom)
        }.padding()
    }
    
    var body: some View {
        NavigationView {
            Main.navigationBarTitle(Text("chmody"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
