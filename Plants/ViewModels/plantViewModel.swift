//
//  plantViewModel.swift
//  Plants
//
//  Created by Fay  on 22/10/2025.
//

import SwiftUI
import Combine

final class plantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    
    func addPlant(name: String, location: String, sunlight: String, water: String) {
          let newPlant = Plant(name: name, location: location, sunlight: sunlight, water: water)
          plants.append(newPlant)
          NotificationManager.shared.scheduleNotification(for: newPlant)
      }
      
      func deletePlant(_ plant: Plant) {
          plants.removeAll { $0.id == plant.id }
          NotificationManager.shared.removeNotification(for: plant)
      }
}
    

    

