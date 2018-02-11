//
//  MovieDetailViewController.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import UIKit

import ReSwift
import RxCocoa
import RxSwift

class MovieDetailViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {

    }
}

extension MovieDetailViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = MovieDetailViewState

    func newState(state: MovieDetailViewState) {
        title = state.title
    }
}
