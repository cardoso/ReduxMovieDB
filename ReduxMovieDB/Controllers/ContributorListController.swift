//
//  ContributorListController.swift
//  ReduxMovieDB
//
//  Created by Christopher Fredregill on 10/12/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import UIKit
import SwiftUI
import ReSwift

class ContributorListController: UIHostingController<ContributorList> {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContributorList())
    }

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
}

extension ContributorListController: StoreSubscriber {
    typealias StoreSubscriberStateType = MainState

    func newState(state: MainState) {
        self.rootView.contributorData = state.contributors
    }
}
