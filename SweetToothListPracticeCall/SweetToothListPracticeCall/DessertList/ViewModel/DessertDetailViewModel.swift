//
//  DessertDetailViewModel.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import Foundation

@MainActor
final class DessertDetailViewModel: ObservableObject {
    
    @Published var dessertDetails: Details?
    @Published var errorMessages: String?
    
    func fetchDessertDetails(mealID: String) async {
        do {
            let dessertDetails = try await WebService().fetchDessertDetailData(mealID: mealID)
            self.dessertDetails = dessertDetails
        } catch(let error) {
            self.errorMessages = error.localizedDescription
        }
    }
    
    // Helper to get ingredient count
    func getIngredientCount() -> Int {
        guard let details = dessertDetails else { return 0 }
        let ingredients = [details.strIngredient1,
                           details.strIngredient2,
                           details.strIngredient3,
                           details.strIngredient4,
                           details.strIngredient5,
                           details.strIngredient6,
                           details.strIngredient7,
                           details.strIngredient8,
                           details.strIngredient9,
                           details.strIngredient10,
                           details.strIngredient11,
                           details.strIngredient12,
                           details.strIngredient13,
                           details.strIngredient14,
                           details.strIngredient15,
                           details.strIngredient16,
                           details.strIngredient17,
                           details.strIngredient18,
                           details.strIngredient19,
                           details.strIngredient20]
        
        let measures = [details.strMeasure1,
                        details.strMeasure2,
                        details.strMeasure3,
                        details.strMeasure4,
                        details.strMeasure5,
                        details.strMeasure6,
                        details.strMeasure7,
                        details.strMeasure8,
                        details.strMeasure9,
                        details.strMeasure10,
                        details.strMeasure11,
                        details.strMeasure12,
                        details.strMeasure13,
                        details.strMeasure14,
                        details.strMeasure15,
                        details.strMeasure16,
                        details.strMeasure17,
                        details.strMeasure18,
                        details.strMeasure19,
                        details.strMeasure20]
        
        return zip(ingredients, measures).filter { $0.0?.isEmpty == false && $0.1?.isEmpty == false }.count
    }

    // Helper to get ingredient based on index
    func getIngredient(at index: Int) -> String? {
        guard let details = dessertDetails else { return nil }
        let ingredients = [details.strIngredient1,
                           details.strIngredient2,
                           details.strIngredient3,
                           details.strIngredient4,
                           details.strIngredient5,
                           details.strIngredient6,
                           details.strIngredient7,
                           details.strIngredient8,
                           details.strIngredient9,
                           details.strIngredient10,
                           details.strIngredient11,
                           details.strIngredient12,
                           details.strIngredient13,
                           details.strIngredient14,
                           details.strIngredient15,
                           details.strIngredient16,
                           details.strIngredient17,
                           details.strIngredient18,
                           details.strIngredient19,
                           details.strIngredient20]
        
        return ingredients[index]?.isEmpty == false ? ingredients[index] : nil
    }

    // Helper to get measure based on index
    func getMeasure(at index: Int) -> String? {
        guard let details = dessertDetails else { return nil }
        let measures = [details.strMeasure1,
                        details.strMeasure2,
                        details.strMeasure3,
                        details.strMeasure4,
                        details.strMeasure5,
                        details.strMeasure6,
                        details.strMeasure7,
                        details.strMeasure8,
                        details.strMeasure9,
                        details.strMeasure10,
                        details.strMeasure11,
                        details.strMeasure12,
                        details.strMeasure13,
                        details.strMeasure14,
                        details.strMeasure15,
                        details.strMeasure16,
                        details.strMeasure17,
                        details.strMeasure18,
                        details.strMeasure19,
                        details.strMeasure20]
        
        return measures[index]?.isEmpty == false ? measures[index] : nil
    }
}
