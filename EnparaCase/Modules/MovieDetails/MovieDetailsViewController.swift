//
//  MovieDetailsViewController.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 10.08.2022.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, MovieDetailsViewModel {
    @IBOutlet private var movieBackground: UIImageView!
    @IBOutlet private var moviePoster: UIImageView!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var popularityLabel: UILabel!
    @IBOutlet private var pointLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            configureContents(with: movie)
        }
    }
    
    private var movieId: Int? {
        didSet {
            getMovies(byId: movieId ?? 0) { movie in
                self.movie = movie
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var setNavigationTitle: String? {
        didSet {
            self.title = setNavigationTitle
        }
    }
    
    var setMovieId: Int? {
        didSet {
            self.movieId = setMovieId ?? 0
        }
    }
}

// MARK: - Configure
extension MovieDetailsViewController {
    
    private func configureContents(with movie: Movie) {
        guard let poster = URL(string: movie.posterImage) else { return }
        guard let background = URL(string: movie.backgroundImage) else { return }
        
        configureMoviePoster(withSource: poster)
        configureMovieBackground(withSource: background)
        configureLabels(withMovie: movie)
    }
    
    private func configureMoviePoster(withSource poster: URL) {
        moviePoster.kf.setImage(with: poster)
        moviePoster.layer.cornerRadius = 15
        moviePoster.layer.masksToBounds = true
    }
    
    private func configureMovieBackground(withSource background: URL) {
        movieBackground.kf.setImage(with: background)
        movieBackground.applyBlurEffect()
    }
    
    private func configureLabels(withMovie movie: Movie) {
        overviewLabel.text = movie.overview
        popularityLabel.text = "Popularity: \((movie.popularity ?? 0).formatted())"
        pointLabel.text = "AVG Vote: \((movie.voteAverage ?? 0).formatted())"
    }
}
