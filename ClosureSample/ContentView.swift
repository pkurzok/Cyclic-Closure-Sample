//
//  ContentView.swift
//  ClosureSample
//
//  Created by Peter Kurzok on 13.01.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Hello, world!")

                NavigationLink("Go to Detail", isActive: $viewModel.showDetail) {
                    ContentDetailView()
                }
            }
            .padding(20)
        }
    }
}

struct ContentDetailView: View {
    @StateObject var viewModel = ContentDetailViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.message)

            Button("Do Some Work", action: viewModel.onDoSomeWork)
        }
        .padding(20)
        .navigationTitle("Detail")
    }
}
