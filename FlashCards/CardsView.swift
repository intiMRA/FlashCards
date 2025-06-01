//
//  ContentView.swift
//  FlashCards
//
//  Created by ialbuquerque on 12/05/2025.
//

import SwiftUI

struct CardsView: View {
    @State var viewModel: CardsViewModel = CardsViewModel()
    var body: some View {
        VStack {
            if viewModel.isValidIndex {
                VStack {
                    AsyncImage(url: URL(string: viewModel.cards[viewModel.currentIndex].imageUrl)) { image in
                        image
                            .image?.resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                .padding(.all, 16)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Gradient(colors: [.red]))
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 1, y: 1))
                .padding(.horizontal, 10)
            }
            
            HStack {
                Button {
                    viewModel.perv()
                } label: {
                    Text("Prev")
                }
                
                Spacer()
                
                Button {
                    viewModel.next()
                } label: {
                    Text("Next")
                }
            }
        }
        .padding()
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    CardsView()
}
