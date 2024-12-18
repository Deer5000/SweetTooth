//
//  SweetToothListViewModel.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import Foundation

@MainActor
final class SweetToothListViewModel: ObservableObject {
    
    @Published var dessertList: [Meal]?
    @Published var errorMessages: String?
    
    func fetchDessertList() async {
        do {
            let dessertList = try await WebService().fetchDessertListData()
            self.dessertList = dessertList
            
        } catch(let error) {
            self.errorMessages = error.localizedDescription
        }
    }
}
