//
//  ContentListView.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 24.09.2024.
//

import SwiftUI
import Alamofire

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryListViewModel()
    @State private var searchQuery = "" // State variable for search input

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                SearchBar(text: $searchQuery)
                    .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    EmptyState(message: "\(error.localizedDescription)")
                } else {
                    ListView(data: filteredRepositories)
                        .refreshable {
                            await viewModel.fetchRepositories()
                        }
                }
            }
            .padding()
            .navigationBarTitle("Repositories")
        }
        .onAppear {
            Task {
                await viewModel.fetchRepositories()
            }
        }
    }

    // Computed property to filter repositories based on search query
    private var filteredRepositories: [Repository] {
        if searchQuery.isEmpty {
            return viewModel.repositories
        } else {
            return viewModel.repositories.filter { repository in
                repository.full_name.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
}


#Preview {
    RepositoryListView()
}

