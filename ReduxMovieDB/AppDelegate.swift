//
//  AppDelegate.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/11/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        mainStore.dispatch(fetchMovieGenres)
        mainStore.dispatch(fetchMoviesPage)
        mainStore.dispatch(fetchContributors)

        window?.rootViewController = ContributorListController(rootView: ContributorList())

        return true
    }
}
