//
//  RepositoryListViewModel.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 24.09.2024.
//

import Foundation
import Alamofire
import SwiftUI



import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let full_name: String
    let description: String?
    let stargazersCount: Int?
    let forksCount: Int?
    let owner: Owner
    struct Owner: Codable {
        let avatar_url: String?
        let html_url: String?
    }
}

class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var error: Error?

    func fetchRepositories() async {
        isLoading = true
        error = nil

        do {
            let repositories = try await fetchRepositoriesFromAPI()
            self.repositories = repositories
        } catch {
            self.error = error
        }

        isLoading = false
    }

    private func fetchRepositoriesFromAPI() async throws -> [Repository] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("https://api.github.com/repositories")
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let repositories = try JSONDecoder().decode([Repository].self, from: data)
                            continuation.resume(returning: repositories)
                        } catch {
                            // Log the error and print the response data for debugging
                            print("Error decoding JSON: \(error)")
                            print("Response data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }}


