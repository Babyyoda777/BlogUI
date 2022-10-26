//
//  ContentView.swift
//  MyBlog
//
//  Created by Muhammad Shah on 25/10/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var store = BlogPostsStore()
    
    var body: some View {
        TabView {
            MainView()
                .environmentObject(store)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            AllPosts()
                .environmentObject(store)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("See all")
                }
        }
    }
}


struct AllPosts: View {
    @EnvironmentObject var store: BlogPostsStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.blogPosts) {post in
                    NavigationLink(destination: BlogPostView(blogPost: post)) {
                        BlogPostCardList(blogPost: post)
                    }
                }
            }
            .navigationTitle("All blog posts")
            .listStyle(InsetListStyle())
        }
    }
}
