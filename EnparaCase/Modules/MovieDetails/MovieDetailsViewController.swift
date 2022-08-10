//
//  MovieDetailsViewController.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 10.08.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNavigationTitle(withMovieName name: String) {
        self.title = name
    }
    
    func setMovieId(_ id: Int) {
        self.movieId = id
    }
}
