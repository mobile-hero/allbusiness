//
//  PokemonListAPI.swift
//  PokemonLibrary
//
//  Created by Muhammad Ikhsan on 12/02/22.
//

import Foundation

class PokemonListAPI: PokemonAPI {
    init(q: String, page: Int, pageSize: Int, orderBy: String?) {
        let query: [String: Any] = ["q": q, "page": page, "pageSize": pageSize, "orderBy": orderBy ?? ""]
        super.init(path: "/cards", method: .get, task: .requestWith(query: query))
    }
}
