//
//  ContentView.swift
//  Plants
//
//  Created by Fay  on 19/10/2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = plantViewModel()

    var body: some View {
        if viewModel.plants.isEmpty {
            homeView(viewModel: viewModel)
        } else {
            mainMenu(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
