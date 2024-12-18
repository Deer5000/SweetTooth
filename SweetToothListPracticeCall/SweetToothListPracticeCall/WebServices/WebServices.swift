//
//  WebServices.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import Foundation


final class WebService {
    
    func fetchDessertListData() async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let desserts = try decoder.decode(Desserts.self, from: data)
            return desserts.meals
        } catch {
            throw ErrorCases.invalidData
        }
    }
    
    func fetchDessertDetailData(mealID: String) async throws -> Details {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let dessertDetails = try decoder.decode(DessertDetails.self, from: data)
            guard let firstDetail = dessertDetails.meals.first else {
                throw ErrorCases.invalidData
            }
            return firstDetail
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw ErrorCases.invalidData
        }
    }
}
