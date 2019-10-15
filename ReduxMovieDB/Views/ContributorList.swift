//
//  ContributorsList.swift
//  ReduxMovieDB
//
//  Created by Christopher Fredregill on 10/10/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import SwiftUI
import ReSwift
import Nuke

struct ContributorList: View {

    var contributorData: [Contributor] = []

    var body: some View {
        ZStack {
            NavigationView() {
                List(contributorData) { contributor in
                    ContributorRow(contributor: contributor)
                }.navigationBarTitle(NSLocalizedString("CONTRIBUTORS", comment: "Contributor list title"))
            }
        }
    }
}

struct ContributorRow: View {

    let contributor: Contributor

    var body: some View {
        NavigationLink(destination: ContributorProfile(contributor: contributor)) {
            HStack {
                Text(contributor.name).frame(height: 10, alignment: .leading)
            }.font(.title)
        }
    }
}

extension Contributor: Identifiable {}
