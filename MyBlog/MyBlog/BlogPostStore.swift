//
//  BlogPostStore.swift
//  MyBlog
//
//  Created by Muhammad Shah on 25/10/2022.
//

import Foundation

class BlogPostsStore: ObservableObject {
    @Published var blogPosts: [BlogPost] = articleList
    
    init() {
        DispatchQueue.main.async {
            self.refreshView()
        }
    }
    func refreshView(){
        blogPosts = []
        DispatchQueue.main.async {
            getArray(id: "swiftBlog") {items in
                items.forEach {(item) in
                    self.blogPosts.append(
                        BlogPost(
                            title: item.fields["title"] as! String,
                            subtitle: item.fields["subtitle"] as? String ?? "",
                            image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: ""),
                            blogpost: item.fields["blogpost"] as? String ?? "",
                            featured: item.fields["featured"] as? Bool ?? false
                        )
                    )
                }
            }
        }
    }
}
