//
//  UITableView+DiffUpdate.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 11/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import UIKit

import DifferenceKit

extension UITableView {
    func diffUpdate<D: Differentiable>(source: [D], target: [D], setData: ([D]) -> Void) {
        let changeset = StagedChangeset(source: source, target: target)
        reload(using: changeset, with: .fade, setData: setData)
    }
}
