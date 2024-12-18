//
//  ContentView.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import SwiftUI

struct DessertListView: View {
    
    @ObservedObject var viewModel = SweetToothListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Use a soft pastel background color
                Color(UIColor.systemPink.withAlphaComponent(0.1))
                    .ignoresSafeArea()
                
                if let desserts = viewModel.dessertList {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(desserts, id: \.idMeal) { meal in
                                NavigationLink(destination: DessertDetailView(meal: meal)) {
                                    HStack {
                                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 70, height: 70)
                                                .clipShape(Circle()) // Use a circle for the meal image
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.pink, lineWidth: 2) // Add a border around the image
                                                )
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        // Vertical stack for text with some padding
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(meal.strMeal)
                                                .font(.headline)
                                                .foregroundColor(.brown) // Dessert-like color
                                            
                                            // Add an optional subtitle or description
                                            Text("A delightful treat!")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.leading, 10)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white)
                                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                                    )
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    ProgressView("Loading Desserts...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchDessertList()
            }
        }
    }
}

#Preview {
    DessertListView()
}

