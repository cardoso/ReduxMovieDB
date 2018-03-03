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
        mainStore.subscribe(self, transform: {
            $0.select(MovieDetailViewState.init)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)

        if case let .show(movie) = mainStore.state.movieDetail {
            mainStore.dispatch(MainStateAction.willHideMovieDetail(movie))
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainStore.dispatch(MainStateAction.hideMovieDetail)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updatePosterView()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)

        if indexPath.section == 1 && indexPath.row == 2 {
            return overviewLabel.sizeThatFits(
                CGSize(
                    width: overviewLabel.frame.size.width,
                    height: .greatestFiniteMagnitude
                )
            ).height + defaultHeight
        }

        return defaultHeight
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
        tableView.beginUpdates()

        title = state.title
        titleLabel.text = state.title
        releaseDateLabel.text = state.date
        genreLabel.text = state.genres
        overviewLabel.text = state.overview

        tableView.endUpdates()

        if let movie = state.movie {
            posterImageView.setPosterForMovie(movie)
        } else {
            posterImageView.image = nil
        }
    }
}
