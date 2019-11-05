//
//  ContentView.swift
//  Moonshot
//
//  Created by Saif on 01/11/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var showLaunchDates = true
    @State var crews = [String]()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(0..<missions.count) { index in
                    NavigationLink(destination: MissionView(mission: self.missions[index], astronauts: self.astronauts)) {
                    Image(self.missions[index].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(self.missions[index].displayName)
                            .font(.headline)
                        Text(self.showLaunchDates ? self.missions[index].formattedLaunchDate : self.crews[index])
                    }
                }
            }
        }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showLaunchDates = !self.showLaunchDates
                    if self.showLaunchDates {
                        
                    }
                    else{
                       self.calculateMembers()
                    }
                }, label: {
                    Text(self.showLaunchDates ? "Crew?" : "Launch Date?")
                })
            )
        }
    }
    
    func calculateMembers() {

        var matches = ""

        for mission in missions {
            for member in mission.crew {
                if let astranaut = astronauts.first(where: { $0.id == member.name }) {
                    matches.append(astranaut.name + ", ")
                } else {
                    fatalError("Missing \(member)")
                }
            }
            matches = String(matches.dropLast())
            matches = String(matches.dropLast())
            crews.append(matches)
            matches = ""
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


/*
 
 GeometryReader { geo in
 Image("Halloween")
 .resizable()
 .aspectRatio(contentMode: .fill)
 .frame(width:geo.size.width)
 }
 .edgesIgnoringSafeArea(.all)
 
 
 
 ScrollView(.vertical) {
 VStack(spacing: 10) {
 ForEach(0..<100) {
 Text("Item \($0)")
 .font(.title)
 }
 }
 .frame(maxWidth: .infinity)
 }
 
 
 
 NavigationView {
     List(0..<100) { row in
             NavigationLink(destination:Text("Row \(row)")) {
                 Text("Row \(row)")
             }
         }
     .navigationBarTitle("SwiftUI")
     }
 }
 
 
 
 NavigationView {
 Button("Decode JSON") {
     let input = """
     {
         "name": "Taylor Swift",
         "address": {
             "street": "555, Taylor Swift Avenue",
             "city": "Nashville"
         }
     }
     """

     let data = Data(input.utf8)
     let decoder = JSONDecoder()
     if let user = try? decoder.decode(User.self, from: data) {
         print(user.address.street)
     }
 }
 .navigationBarTitle("SwiftUI")
 }
 */
