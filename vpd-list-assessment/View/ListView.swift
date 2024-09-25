//
//  ListView.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 25.09.2024.
//

import SwiftUI

struct ListView: View {
    var data: [Repository]

    var body: some View {
        List(data) { repository in
            NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                HStack {
                    ImageLoader(
                        url: URL(string: repository.owner.avatar_url ?? ""),                        placeholder: Image(systemName: "person.fill"),
                        errorImage: Image(systemName: "person.fill"),
                        size: CGSize(width: 80, height: 80), imageShape: Circle()
                    )

                    VStack(alignment: .leading) {
                        Text(repository.full_name)
                            .font(.title2)
                            .bold()
                        
                        if let description = repository.description {
                            Text(description)
                                .font(.body)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("⭐️ \(repository.stargazersCount)")
                            Text("🍴 \(repository.forksCount)")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    ListView(
        data: [
            Repository(
                id: 1,
                full_name: "Example Repo",
                description: "A sample description.",
                stargazersCount: 100,
                forksCount: 20,
                owner: Repository.Owner(avatar_url: "https://avatars.githubusercontent.com/u/4?v=4", html_url: "https://github.com/wycats")
            )
        ]
    )
}
