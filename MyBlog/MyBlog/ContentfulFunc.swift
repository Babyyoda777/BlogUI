//
//  ContentfulFunc.swift
//  MyBlog
//
//  Created by Muhammad Shah on 25/10/2022.
//

import Foundation
import Contentful

let client = Client(spaceId: "v8d58es6cbnq", environmentId: "master", accessToken: "b7pwKrTPRTOCI1ssgRu5WuNVOCn3zxsRQWt_WxXKegI")

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    try! query.order(by: Ordering(sys: .createdAt, inReverse: true)) // ordering the list of articles by created date
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
            case .success(let array):
                DispatchQueue.main.async {
                    completion(array.items)
                }
            case .failure(let error):
                print(error)
        }
    }
}
