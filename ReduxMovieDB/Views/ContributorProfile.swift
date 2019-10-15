//
//  ContributorDetail.swift
//  ReduxMovieDB
//
//  Created by Christopher Fredregill on 10/12/19.
//  Copyright © 2019 Matheus Cardoso. All rights reserved.
//

import SwiftUI
import ReSwift

struct ContributorProfile: View {

    var contributor: Contributor

    var body: some View {
        VStack {
            contributor.avatar.map { Image(uiImage: $0) }
            Text(contributor.login)
            Text(contributor.html_url)
            contributor.company.map(Text.init)
            contributor.blog.map(Text.init)
            contributor.email.map(Text.init)
        }.navigationBarTitle(contributor.name)
    }
}
