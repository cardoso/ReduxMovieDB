//
//  SplitViewController.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import UIKit

import ReSwift

class SplitViewController: UISplitViewController {
    var movieListViewController: MovieListViewController? {
        let navigationController = viewControllers.first as? UINavigationController
        return navigationController?.topViewController as? MovieListViewController
    }

    var movieDetailViewController: MovieDetailViewController? {
        let navigationController = viewControllers.last as? UINavigationController
        return navigationController?.topViewController as? MovieDetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .allVisible
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

// MARK: StoreSubscriber

extension SplitViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {
        if state.showMovieDetail && movieDetailViewController == nil {
            movieListViewController?.performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
}

// MARK: UISplitViewControllerDelegate

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
