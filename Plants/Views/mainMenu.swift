//
//  mainMenu.swift
//  Plants
//
//  Created by Fay  on 20/10/2025.
//


import SwiftUI


struct PlantRow: View {
    @Binding var plant: Plant
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Circle check button
            Button(action: {
                plant.isChecked.toggle()
            }) {
                Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 25))
                    .foregroundColor(plant.isChecked ? .newonGreen : .gray)
            }
            .padding(.top, 28)
            .contentShape(Rectangle()) // defines hit area
            .buttonStyle(PlainButtonStyle()) // prevents unwanted highlight animations
            
            VStack(alignment: .leading, spacing: 6) {
                    HStack (spacing: 3) {
                        Image(systemName: "location")
                                           .foregroundColor(.gray)
                                           .font(.system(size: 16))
                    Text("in \(plant.location)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Text(plant.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    TagView(icon: "sun.max", text: plant.sunlight ,color: .yellewC)
                    TagView(icon: "drop", text: plant.water ,color: .blueC)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.black)
    }
}

struct TagView: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .foregroundColor(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color(.boxG))
        .cornerRadius(8)

       
    }
}


struct mainMenu: View {
    @ObservedObject var viewModel: plantViewModel
    @State private var showAddSheet = false
    @State private var showEditSheet = false
    @State private var selectedPlant: Plant?

    
   
    var body: some View {
          ZStack {
              Color.black.ignoresSafeArea()
              
              // MARK: - All Done View
              if viewModel.plants.allSatisfy({ $0.isChecked }) && !viewModel.plants.isEmpty {
                  allDoneView
                      .transition(.opacity.combined(with: .scale))
                      .animation(.easeInOut, value: viewModel.plants)
              } else {
                  // MARK: - Main List View
                  VStack(alignment: .leading, spacing: 16) {
                      Text("My Plants 🌱")
                          .font(.system(size: 34, weight: .bold))
                          .foregroundColor(.white)
                          .padding(.top, 40)
                          .padding(.horizontal, 10)
                      
                      Rectangle()
                          .fill(Color.gray.opacity(0.2))
                          .frame(height: 2)
                      
                      VStack(spacing: 8) {
                          Text(progressText)
                              .font(.system(size: 18))
                              .foregroundColor(.white)
                              .animation(.easeInOut, value: progressText)
                          
                          ProgressView(value: progress)
                              .tint(.newonGreen)
                              .frame(width: 350)
                              .scaleEffect(x: 1, y: 2, anchor: .center)
                              .padding()
                              .animation(.easeInOut(duration: 0.4), value: progress)
                      }
                      
                      List {
                          ForEach($viewModel.plants) { $plant in
                              PlantRow(plant: $plant)
                                  .contentShape(Rectangle()) // ensures full row is tappable
                                  .onTapGesture {
                                      selectedPlant = plant
                                      showEditSheet = true
                                  }
                                  .swipeActions(edge: .trailing) {
                                      Button(role: .destructive) {
                                          withAnimation {
                                              viewModel.deletePlant(plant)
                                          }
                                      } label: {
                                          Label("", systemImage: "trash")
                                      }
                                  }
                          }
                          .listRowBackground(Color.black)
                      }
                      .listStyle(.plain)
                      .scrollContentBackground(.hidden)
                  }
                  .transition(.opacity)
                  
                  // Floating add button
                  VStack {
                      Spacer()
                      HStack {
                          Spacer()
                          Button {
                              showAddSheet = true
                          } label: {
                              Image(systemName: "plus")
                                  .font(.system(size: 22, weight: .bold))
                                  .foregroundColor(.white)
                                  .padding(20)
                                  .glassEffect(.regular.tint(.greenAccent).interactive())
                                 // .background(Color.newonGreen)
                                  .clipShape(Circle())
                                  .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
                          }
                          .padding(.trailing, 25)
                          .padding(.bottom, 35)
                      }
                  }
              }
          }
          .sheet(isPresented: $showAddSheet) {
              ReminderSheetView { name, room, light, waterDays in
                  viewModel.addPlant(name: name, location: room, sunlight: light, water: waterDays)
                  showAddSheet = false
              }
          }
          .sheet(item: $selectedPlant) { plant in
              if let index = viewModel.plants.firstIndex(of: plant) {
                  RowSheetView(viewModel: viewModel, plant: $viewModel.plants[index])
                      .presentationDetents([.large])
                      .presentationDragIndicator(.visible)
              }
          }
      }
      
      // MARK: - Computed Properties
      
      private var progress: Double {
          guard !viewModel.plants.isEmpty else { return 0 }
          let checkedCount = viewModel.plants.filter { $0.isChecked }.count
          return Double(checkedCount) / Double(viewModel.plants.count)
      }
      
      private var progressText: String {
          let unchecked = viewModel.plants.filter { !$0.isChecked }.count
          
          switch unchecked {
          case 0:
              return "All plants are happy today! 🌿"
          case 1:
              return "1 of your plants is waiting for love today 💧"
          default:
              return "\(unchecked) of your plants are waiting to be loved today 💦"
          }
      }
      
      //  All Done View
      
    private var allDoneView: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 16) {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .padding(.horizontal, 10)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 2)
                        .padding(.horizontal, 10)
                }
                
                Spacer()
                
                // Centered content
                VStack {
                    Image("plantWink")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 280)
                    
                    Text("All done! 🎉")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                       // .padding(.top, 10)
                    
                    Text("All reminders Completed")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .opacity(0.8)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            
            // Floating Button
            Button {
                showAddSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.newonGreen)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
            }
            .padding(.trailing, 25)
            .padding(.bottom, 35)
        }
    }

  }

#Preview {
    mainMenu(viewModel: plantViewModel())
}
