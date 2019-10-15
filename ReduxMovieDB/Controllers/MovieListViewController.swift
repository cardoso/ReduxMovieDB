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
import RxKeyboard
import SwiftUI

class MovieListViewController: UIViewController {
    var movies: [Movie] = []

    let disposeBag = DisposeBag()

    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.backgroundView = UIView()
            moviesTableView.backgroundView?.backgroundColor = moviesTableView.backgroundColor

            moviesTableView.rx.itemSelected
                .map { self.movies[$0.row] }
                .map(MainStateAction.showMovieDetail)
                .bind(onNext: mainStore.dispatch)
                .disposed(by: disposeBag)

            moviesTableView.rx.willDisplayCell
                .filter { $1.row == mainStore.state.movies.count - 1 }
                .map { _ in fetchMoviesPage }
                .bind(onNext: mainStore.dispatch)
                .disposed(by: disposeBag)
        }
    }

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.rx.textDidBeginEditing
                .filter { (self.searchBar.text?.isEmpty ?? false) && mainStore.state.canDispatchSearchActions }
                .bind(onNext: {
                    mainStore.dispatch(MainStateAction.readySearch)
                    mainStore.dispatch(fetchMoviesPage)
                })
                .disposed(by: disposeBag)

            searchBar.rx.text.orEmpty
                .filter { !$0.isEmpty && mainStore.state.canDispatchSearchActions }
                .bind(onNext: {
                    mainStore.dispatch(MainStateAction.search($0))
                    mainStore.dispatch(fetchMoviesPage)
                })
                .disposed(by: disposeBag)

            searchBar.rx.text.orEmpty
                .filter { $0.isEmpty && mainStore.state.canDispatchSearchActions }
                .bind(onNext: { _ in
                    mainStore.dispatch(MainStateAction.readySearch)
                    mainStore.dispatch(fetchMoviesPage)
                })
                .disposed(by: disposeBag)

            searchBar.rx.cancelButtonClicked
                .bind(onNext: {
                    mainStore.dispatch(MainStateAction.cancelSearch)
                    mainStore.dispatch(fetchMoviesPage)
                })
                .disposed(by: disposeBag)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("FILMS", comment: "Films view controller title")
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { height in
                self.additionalSafeAreaInsets.bottom = height
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self, transform: {
            $0.select(MovieListViewState.init)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
}

// MARK: StoreSubscriber

extension MovieListViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = MovieListViewState

    func newState(state: MovieListViewState) {
        moviesTableView.diffUpdate(source: movies, target: state.movies) {
            self.movies = $0
        }

        searchBar.text = state.searchBarText
        searchBar.showsCancelButton = state.searchBarShowsCancel

        switch (searchBar.isFirstResponder, state.searchBarFirstResponder) {
        case (true, false): searchBar.resignFirstResponder()
        case (false, true): searchBar.becomeFirstResponder()
        default: break
        }
    }
}

// MARK: UITableViewDataSource

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        accessoryType = selected ? .none : .disclosureIndicator
    }

    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }

            icon.setPosterForMovie(movie)
            title.text = movie.title
            subtitle.text = movie.releaseDate?.description ?? ""
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        cell.movie = movies[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        cell.selectionStyle = .none

        return cell
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
}
