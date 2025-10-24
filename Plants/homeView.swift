//
//  homeView.swift
//  Plants
//
//  Created by Fay  on 19/10/2025.
//
import SwiftUI

struct homeView: View {
    @ObservedObject var viewModel: plantViewModel
        @State private var showSheet = false

    var body: some View {
          ZStack {
              Color.black.ignoresSafeArea()
              
              VStack {
                  Image("plantIcon")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 160, height: 200)
                  
                  Text("Start your plant journey")
                      .font(.system(size: 25, weight: .bold))
                      .foregroundColor(.white)
                      .padding(.top, 40)
                  
                  Text("All your plants in one place. We'll help you care for them 🌿")
                      .font(.system(size: 16, weight: .light))
                      .foregroundColor(.gray)
                      .padding(.top, 10)
                      .opacity(0.8)
                      .padding(.horizontal, 20)
                  
                  Button("Set a plant reminder") {
                      showSheet = true
                  }
                  .frame(width: 280, height: 44)
                  .glassEffect(.regular.tint(.greenAccent))
                  .foregroundColor(.white)
                  .padding(.top, 40)
              
              }
          }
          .sheet(isPresented: $showSheet) {
              ReminderSheetView { name, room, light, waterDays in
                  viewModel.addPlant(name: name, location: room, sunlight: light, water: waterDays)
                  showSheet = false
              }
              
          }
      }
  }
#Preview {
    homeView(viewModel: plantViewModel())
}
