//
//  rowSheetView.swift
//  Plants
//
//  Created by Fay  on 20/10/2025.
//


import SwiftUI


struct RowSheetView: View {
    @ObservedObject var viewModel: plantViewModel
    @Binding var plant: Plant
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedRoom: String = ""
    @State private var selectedLight: String = ""
    @State private var selectedWaterDays: String = ""
    @State private var selectedWaterAmount: String = ""
    
    // Menu data
    let roomOptions = ["Bedroom",
                       "Living Room",
                       "Kitchen",
                       "Balcony",
                       "Bathroom"]
    let lightOptions = ["Full Sun",
                        "Partial Sun",
                        "Low Light"]
    let waterDaysOptions = ["Every day",
                            "Every 2 days",
                            "Every 3 days",
                            "Once a week",
                            "Every 10 days",
                            "Every 2 weeks"]
    let waterAmountOptions = ["20-50 ml",
                              " 50-100 ml",
                              "100-200 ml",
                              "200-300 ml"]
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color.clear.ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer().frame(height: 20)
                    
                    // MARK: - Room & Light
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: "location").foregroundColor(.white)
                            Text("Room").foregroundColor(.white.opacity(0.8))
                            Menu {
                                ForEach(roomOptions, id: \.self) { option in
                                    Button(option) { selectedRoom = option }
                                }
                            } label: { menuLabel(selectedRoom) }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        
                        DividerLine()
                        
                        HStack {
                            Image(systemName: "sun.max").foregroundColor(.white)
                            Text("Light").foregroundColor(.white.opacity(0.8))
                            Menu {
                                ForEach(lightOptions, id: \.self) { option in
                                    Button(option) { selectedLight = option }
                                }
                            } label: { menuLabel(selectedLight) }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                    }
                    .menuContainer()
                    .padding(.top, 60)
                    
                    // MARK: Water menus
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: "drop").foregroundColor(.white)
                            Text("Water Days").foregroundColor(.white.opacity(0.8))
                            Menu {
                                ForEach(waterDaysOptions, id: \.self) { option in
                                    Button(option) { selectedWaterDays = option }
                                }
                            } label: { menuLabel(selectedWaterDays) }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        
                        DividerLine()
                        
                        HStack {
                            Image(systemName: "drop.fill").foregroundColor(.white)
                            Text("Water Amount").foregroundColor(.white.opacity(0.8))
                            Menu {
                                ForEach(waterAmountOptions, id: \.self) { option in
                                    Button(option) { selectedWaterAmount = option }
                                }
                            } label: { menuLabel(selectedWaterAmount) }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                    }
                    .menuContainer()
                    
                    // MARK: - Delete Button
                    Button(role: .destructive) {
                        viewModel.deletePlant(plant)
                        dismiss() 
                        print("Delete tapped")
                    } label: {
                        Text("Delete reminder")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color(.inputGray))
                            )
                            .padding(.horizontal, 20)
                    }
                }
                .navigationTitle("Set reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { dismiss() } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // Update plant with new values
                            plant.location = selectedRoom
                            plant.sunlight = selectedLight
                            plant.water = selectedWaterDays
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .glassEffect(.regular.tint(.newonGreen))
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                
                    }.sharedBackgroundVisibility(.hidden)
                }
                .onAppear {
                    // Initialize with current values
                    selectedRoom = plant.location
                    selectedLight = plant.sunlight
                    selectedWaterDays = plant.water
                }
            }
        }
    }
}



   // MARK: - Small helper views
   extension View {
       func menuContainer() -> some View {
           self
               .background(
                   RoundedRectangle(cornerRadius: 25)
                       .fill(Color(.inputGray))
               )
               .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
               .padding(.horizontal, 20)
       }
   }

   private func menuLabel(_ text: String) -> some View {
       HStack {
           Text(text)
               .foregroundColor(.white)
           Image(systemName: "chevron.up.chevron.down")
               .font(.system(size: 12))
               .foregroundColor(.white.opacity(0.7))
       }
       .frame(maxWidth: .infinity, alignment: .trailing)
   }

   private func DividerLine() -> some View {
       Rectangle()
           .fill(Color.white.opacity(0.3))
           .frame(height: 1)
           .padding(.horizontal, 8)
   }
