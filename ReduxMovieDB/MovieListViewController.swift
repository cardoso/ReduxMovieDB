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
        willSet {
            newValue?.rx.itemSelected
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
            self.moviesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none )
        } else if let selectedRows = moviesTableView.indexPathsForSelectedRows {
            selectedRows.forEach {
                self.moviesTableView.deselectRow(at: $0, animated: true)
            }
        }
    }
}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.state.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let movie = store.state.movies[indexPath.row]
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = movie.releaseDate.description
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
