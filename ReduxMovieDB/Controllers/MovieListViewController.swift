//
//  MovieListViewController.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import Combine
import CombineCocoa
import CombineKeyboard
import ReSwift

class MovieListViewController: UIViewController {
    var movies: [Movie] = []

    var cancellables = Cancellables()

    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.backgroundView = UIView()
            moviesTableView.backgroundView?.backgroundColor = moviesTableView.backgroundColor

            moviesTableView.didSelectRowPublisher
                .map { self.movies[$0.row] }
                .map(MainStateAction.showMovieDetail)
                .sink { mainStore.dispatch($0) }
                .store(in: &cancellables)

            moviesTableView.willDisplayCellPublisher
                .filter { $1.row == mainStore.state.movies.count - 1 }
                .map { _ in fetchMoviesPage }
                .sink { mainStore.dispatch($0) }
                .store(in: &cancellables)
        }
    }

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.textDidChangePublisher
                .filter { !$0.isEmpty && mainStore.state.canDispatchSearchActions }
                .sink {
                    mainStore.dispatch(MainStateAction.search($0))
                    mainStore.dispatch(fetchMoviesPage)
                }
                .store(in: &cancellables)

            searchBar.textDidChangePublisher
                .filter { $0.isEmpty && mainStore.state.canDispatchSearchActions }
                .sink { _ in
                    mainStore.dispatch(MainStateAction.readySearch)
                    mainStore.dispatch(fetchMoviesPage)
                }
                .store(in: &cancellables)

            searchBar.cancelButtonClickedPublisher
                .sink {
                    mainStore.dispatch(MainStateAction.cancelSearch)
                    mainStore.dispatch(fetchMoviesPage)
                }
                .store(in: &cancellables)
        }
    }
    
    var isInSplitViewPresentation: Bool {
        return !(splitViewController?.isCollapsed ?? true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = NSLocalizedString("FILMS", comment: "Films view controller title")
        
        CombineKeyboard.shared.height
            .sink { height in
                self.additionalSafeAreaInsets.bottom = height
            }
            .store(in: &cancellables)
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { _ in
            self.moviesTableView.visibleCells.forEach {
                if let cell = $0 as? MovieListTableViewCell {
                    cell.setDisclosureIndicator(visible: !self.isInSplitViewPresentation)
                }
            }
        }
        super.viewWillTransition(to: size, with: coordinator)
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

    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }

            icon.setPosterForMovie(movie)
            title.text = movie.title
            subtitle.text = movie.releaseDate?.description ?? ""
        }
    }
}

extension MovieListTableViewCell {
    func setDisclosureIndicator(visible: Bool) {
        accessoryType = visible ? .disclosureIndicator : .none
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
        cell.setDisclosureIndicator(visible: !isInSplitViewPresentation)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        cell.selectionStyle = .none

        return cell
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
}
