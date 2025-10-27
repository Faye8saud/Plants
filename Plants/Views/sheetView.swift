//
//  sheetView.swift
//  Plants
//
//  Created by Fay  on 19/10/2025.
//

import SwiftUI


struct ReminderSheetView: View {
   
    @Environment(\.dismiss) var dismiss

      @State private var plantName: String = ""
      @State private var selectedRoom = "Bedroom"
      @State private var selectedLight = "Full Sun"
      @State private var selectedWaterDays = "Every Day"
      @State private var selectedWaterAmount = "50-100 ml"

      let roomOption = ["Bedroom",
                        "Living Room",
                        "Kitchen",
                        "Balcony",
                        "Bathroom"]
      let lightOptions = ["Full Sun",
                          "Partial Sun",
                          "Low Light"]
      let waterDaysOption = ["Every day",
                            "Every 2 days",
                             "Every 3 days",
                             "Once a week",
                             "Every 10 days",
                             "Every 2 weeks"]
      let waterOption = ["20-50 ml",
                        "50-100 ml",
                         "100-200 ml",
                         "200-300 ml"]
      
     
      var onSave: ((String, String, String, String) -> Void)?
    
    var body: some View {
        NavigationStack {
        ZStack(alignment: .topLeading) {
      
           // Color.clear.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer().frame(height: 20)
                
                HStack {
                      
                    Text("Plant name |")
                             .foregroundColor(.white.opacity(0.8))
                             .font(.system(size: 16, weight: .medium))
                         

                       TextField("pothos", text: $plantName)
                           .foregroundColor(.white)
                           .font(.system(size: 16))
                       
                   }
                   .padding(.horizontal, 16)
                   .frame(height: 50)
                   .background(
                       RoundedRectangle(cornerRadius: 25)
                           .fill(Color(.inputGray))
                   )
                   .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                   .padding(.horizontal, 20)
                
                  //menues 1
                
                VStack(spacing: 0) {
                       //  Top Menu: room
                    HStack {
                                        Image(systemName: "location")
                                            .foregroundColor(.white)
                                        Text("Room")
                                            .foregroundColor(.white.opacity(0.8))
                                        Menu {
                                            ForEach(roomOption, id: \.self) { type in
                                                Button(type) { selectedRoom = type }
                                            }
                                        } label: {
                                            menuLabel(selectedRoom)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 50)
                                    
                                    Rectangle().fill(Color.white.opacity(0.3))
                                        .frame(height: 1).padding(.horizontal, 8)
                                    
                                    // Light
                                    HStack {
                                        Image(systemName: "sun.max")
                                            .foregroundColor(.white)
                                        Text("Light")
                                            .foregroundColor(.white.opacity(0.8))
                                        Menu {
                                            ForEach(lightOptions, id: \.self) { size in
                                                Button(size) { selectedLight = size }
                                            }
                                        } label: {
                                            menuLabel(selectedLight)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 50)
                                }
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color(.inputGray)))
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                                .padding(.horizontal, 20)
                                
                                
                                VStack(spacing: 0) {
                                    // Water Days
                                    HStack {
                                        Image(systemName: "drop")
                                            .foregroundColor(.white)
                                        Text("Water Days")
                                            .foregroundColor(.white.opacity(0.8))
                                        Menu {
                                            ForEach(waterDaysOption, id: \.self) { type in
                                                Button(type) { selectedWaterDays = type }
                                            }
                                        } label: {
                                            menuLabel(selectedWaterDays)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 50)
                                    
                                    Rectangle().fill(Color.white.opacity(0.3))
                                        .frame(height: 1).padding(.horizontal, 8)
                                    
                                    // Water Amount
                                    HStack {
                                        Image(systemName: "drop.fill")
                                            .foregroundColor(.white)
                                        Text("Water Amount")
                                            .foregroundColor(.white.opacity(0.8))
                                        Menu {
                                            ForEach(waterOption, id: \.self) { size in
                                                Button(size) { selectedWaterAmount = size }
                                            }
                                        } label: {
                                            menuLabel(selectedWaterAmount)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 50)
                                }
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color(.inputGray)))
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                                .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                           .navigationTitle("Set reminder")
                           .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                              ToolbarItem(placement: .topBarLeading) {
                                  Button {
                                      dismiss()
                                  } label: {
                                      Image(systemName: "xmark")
                                          .font(.system(size: 15, weight: .bold))
                                          .foregroundColor(.white)
                                          .padding(7)
                                          .clipShape(Circle())
                                  }
                              }
                              
                              ToolbarItem(placement: .topBarTrailing) {
                                  Button {
                                      onSave?(plantName, selectedRoom, selectedLight, selectedWaterDays)
                                      dismiss()
                                  }
                                  label: {
                                      Image(systemName: "checkmark")
                                          .font(.system(size: 15, weight: .bold))
                                          .foregroundColor(.white)
                                  }
                                  .buttonStyle(.borderedProminent)
                                  .tint(Color.newonGreen)
                                  .foregroundStyle(.white)
                                  .clipShape(Circle())
                          
                              }//.sharedBackgroundVisibility(.hidden)
                          }
                      }
                  }
              }
                    
                    // Helper view for compact menu labels
                    @ViewBuilder
                    func menuLabel(_ text: String) -> some View {
                        HStack {
                            Text(text)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }


