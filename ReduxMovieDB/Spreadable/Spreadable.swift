//
//  Spreadable.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/17/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

struct Spread<T: Spreadable> {
    let object: T
}

protocol Spreadable { }

extension Spreadable {
    static prefix func ... (_ object: Self) -> Spread<Self> {
        return Spread<Self>(object: object)
    }
}
