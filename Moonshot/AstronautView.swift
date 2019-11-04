//
//  AstronautView.swift
//  Moonshot
//
//  Created by Saif on 04/11/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    var missionsFlew = [String]()
    
    let astronaut: Astronaut
    var missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width,height:200)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.largeTitle)
                    
                    ForEach(0..<self.missionsFlew.count) { index in
                        HStack {
                            Image(self.getImageName(of: self.missionsFlew[index]))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            Text("\(self.missionsFlew[index])")
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    func getImageName(of image: String) -> String {
        var imageName = image.lowercased()
        imageName = imageName.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        return imageName
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions
        
        var matches = [String]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    matches.append(mission.displayName)
                }
            }
        }
        
        missionsFlew = matches
    }
    
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
