//
//  DessertDetailView.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    @StateObject var detailViewModel = DessertDetailViewModel()
    let meal: Meal
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let detail = detailViewModel.dessertDetails {
                    // Dessert image
                    AsyncImage(url: URL(string: detail.strMealThumb ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .cornerRadius(15)
                            .padding(5) // Add padding for the border
                            .background(
                                RoundedRectangle(cornerRadius: 20) // Border background
                                    .stroke(Color.white, lineWidth: 4) // White border
                            )
                            .shadow(color: Color.black.opacity(0.4), radius: 15, x: 0, y: 10) // Deeper shadow
                            .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 5)  // Additional layered shadow
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // Dessert title
                    Text(meal.strMeal)
                        .font(.largeTitle)
                        .foregroundColor(.brown)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    // Ingredients and Measures
                    if detailViewModel.getIngredientCount() > 0 {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ingredients")
                                .font(.title2)
                                .foregroundColor(.pink)
                                .bold()
                                .padding(.bottom, 5)
                            
                            ForEach(0..<detailViewModel.getIngredientCount(), id: \.self) { index in
                                if let ingredient = detailViewModel.getIngredient(at: index),
                                   let measure = detailViewModel.getMeasure(at: index) {
                                    HStack {
                                        Text(ingredient)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(measure)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Instructions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.title2)
                            .foregroundColor(.pink)
                            .bold()
                            .padding(.bottom, 5)
                        
                        // Split instructions into steps
                        let instructions = detail.strInstructions?.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) } ?? []
                        
                        ForEach(instructions.indices, id: \.self) { index in
                            if !instructions[index].isEmpty {
                                // Each instruction in a new row
                                Text("\(index + 1). \(instructions[index]).")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .lineSpacing(5)
                            }
                        }
                    }
                    .padding() // Same padding as ingredients view
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal) // Same horizontal padding
                } else {
                    // Show loading spinner while data is fetched
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding(.top, 50)
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemPink.withAlphaComponent(0.1)).ignoresSafeArea()) // Light background color
        .navigationTitle(meal.strMeal)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await detailViewModel.fetchDessertDetails(mealID: meal.idMeal)
        }
    }
}
