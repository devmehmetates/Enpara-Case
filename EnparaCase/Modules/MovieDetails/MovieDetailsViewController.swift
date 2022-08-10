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
            guard let poster = URL(string: movie.posterImage) else { return }
            guard let background = URL(string: movie.backgroundImage) else { return }
            moviePoster.kf.setImage(with: poster)
            moviePoster.layer.cornerRadius = 15
            moviePoster.layer.masksToBounds = true
            movieBackground.kf.setImage(with: background)
            movieBackground.applyBlurEffect()
            overviewLabel.text = movie.overview
            popularityLabel.text = "Popularity: \((movie.popularity ?? 0).formatted())"
            pointLabel.text = "AVG Vote: \((movie.voteAverage ?? 0).formatted())"
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
    
    func setNavigationTitle(withMovieName name: String) {
        self.title = name
    }
    
    func setMovieId(_ id: Int) {
        self.movieId = id
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
