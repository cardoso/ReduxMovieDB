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

class MovieDetailViewController: UITableViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    @IBOutlet weak var posterImageView: UIImageView!

    private let posterViewHeight: CGFloat = 300
    private var posterView: UIView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPosterView()
        updatePosterView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self, transform: {
            $0.select(MovieDetailViewState.init)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
        store.dispatch(AppStateAction.deselectMovie)
        store.dispatch(AppStateAction.hideMovieDetail)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updatePosterView()
    }

    func setupPosterView() {
        posterView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(posterView)
        tableView.contentInset = UIEdgeInsets(top: posterViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -posterViewHeight)
    }

    func updatePosterView() {
        var posterRect = CGRect(
            x: 0, y: -posterViewHeight,
            width: tableView.bounds.width, height: posterViewHeight
        )

        if tableView.contentOffset.y < -posterViewHeight {
            posterRect.origin.y = tableView.contentOffset.y
            posterRect.size.height = -tableView.contentOffset.y
        }

        posterView.frame = posterRect
    }
}

// MARK: StoreSubscriber

extension MovieDetailViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = MovieDetailViewState

    func newState(state: MovieDetailViewState) {
        title = state.title
        titleLabel.text = state.title
        releaseDateLabel.text = state.date
        genreLabel.text = state.genres
        overviewLabel.text = state.overview

        guard let movie = state.movie else { return }
        posterImageView.setPosterForMovie(movie)
    }
}
