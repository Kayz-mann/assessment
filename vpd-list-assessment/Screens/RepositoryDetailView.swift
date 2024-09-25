//
//  RepositoryDetailView.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 24.09.2024.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    @State private var showSheet = false

    var body: some View {
        ZStack {
            // Image loader as the background for the whole screen
            ImageLoader(
                url: URL(string: repository.owner.avatar_url ?? ""),
                placeholder: Image(systemName: "person.fill"),
                errorImage: Image(systemName: "xmark.octagon.fill"),
                size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
                imageShape: Rectangle()
            )
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showSheet) {
            BottomSheetView(repository: repository, showSheet: $showSheet) // Pass binding to showSheet
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: EmptyView())
        .onAppear {
            // Configure navigation bar appearance
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            
            // Present the sheet automatically
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showSheet = true
            }
        }
    }
}

struct BottomSheetView: View {
    let repository: Repository
    @Binding var showSheet: Bool // Binding to control sheet visibility

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Button to dismiss the sheet
            Button(action: {
                showSheet = false // Dismiss the sheet
            }) {
                Text("Dismiss")
                    .foregroundColor(.red) // Change color to indicate dismiss action
                    .font(.headline)
                    .padding()
                    .background(Color.clear) // Background transparent
                    .cornerRadius(8)
            }

            Text(repository.full_name)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            
            if let description = repository.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.black)
            }

            HStack {
                Text("⭐️ \(repository.stargazersCount ?? 0)")
                Text("🍴 \(repository.forksCount ?? 0)")
            }
            .font(.subheadline)
            .foregroundColor(.black)
            
            Button(action: {
                if let url = URL(string: repository.owner.html_url ?? "") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Open on GitHub")
                    .foregroundColor(.white) // Text color is white
                    .font(.headline)
                    .padding() // Add padding for a better button appearance
                    .background(Color.green.opacity(0.8)) // Light green background
                    .cornerRadius(8) // Rounded corners for the button
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = Repository(
            id: 1,
            full_name: "Example Repository",
            description: "This is an example repository that demonstrates how to use SwiftUI effectively with various components.",
            stargazersCount: 100,
            forksCount: 50,
            owner: Repository.Owner(avatar_url: "https://avatars.githubusercontent.com/u/4?v=4", html_url: "https://github.com/wycats")
//            html_url: "https://github.com/example/example-repo"
            // Add this property to your Repository model
        )
        RepositoryDetailView(repository: repository)
    }
}


