//
//  MovieListViewController.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import ReSwift
import RxCocoa
import RxSwift

class MovieListViewController: UIViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView?.separatorColor = .clear

            moviesTableView?.rx.itemSelected
                .map { $0.row }
                .filter { $0 < store.state.movies.count }
                .bind(onNext: {
                    store.dispatch(AppStateAction.selectMovieIndex($0))
                    store.dispatch(AppStateAction.showMovieDetail)
                }).disposed(by: disposeBag)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self, transform: {
            $0.select(MovieListViewState.init)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

// MARK: StoreSubscriber

extension MovieListViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = MovieListViewState

    func newState(state: MovieListViewState) {
        moviesTableView.reloadData()
        if let row = state.selectedMovieIndex {
            let indexPath = IndexPath(row: row, section: 0)
            moviesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none )
        } else if let selectedRows = moviesTableView.indexPathsForSelectedRows {
            selectedRows.forEach {
                moviesTableView.deselectRow(at: $0, animated: true)
            }
        }
    }
}

// MARK: UITableViewDataSource

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    var movie: Movie? {
        willSet {
            guard let movie = newValue else { return }

            icon.setPosterForMovie(movie)
            title.text = movie.title
            subtitle.text = movie.releaseDate.description
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.state.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        cell.movie = store.state.movies[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

        return cell
    }
}
