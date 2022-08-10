//
//  MovieCollectionViewCell.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var moviePosterImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var contentUIView: UIView!
    
    private var layoutType: LayoutType = .grid {
        didSet {
            changeCellLayout()
        }
    }
    
    var setMoviePoster: String? {
        didSet {
            guard let posterSource = URL(string: setMoviePoster ?? "") else { return }
            moviePosterImageView.kf.setImage(with: posterSource)
        }
    }
    
    var setmovieTitleLabel: String? {
        didSet {
            movieTitleLabel.text = setmovieTitleLabel
            configureContents()
        }
    }
    
    var setCellLayoutType: LayoutType? {
        didSet {
            self.layoutType = setCellLayoutType ?? .grid
        }
    }
}

// MARK: - Configure
extension MovieCollectionViewCell {
    
    private func configureContents() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentUIView.layer.cornerRadius = 15
        self.contentUIView.layer.masksToBounds = true
    }
}

// MARK: - Constraint
extension MovieCollectionViewCell {
    
    private var gridLayoutConstaints: [NSLayoutConstraint] {
         [
            moviePosterImageView.topAnchor .constraint(equalTo: contentUIView.topAnchor, constant: 0),
            moviePosterImageView.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: 0),
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 27.0.responsiveH),
            
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: -1.0.responsiveW),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -1.0.responsiveW),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 1.0.responsiveW),
            movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 1.0.responsiveW)
         ]
    }
    
    private var listLayoutConstaints: [NSLayoutConstraint] {
         [
            moviePosterImageView.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0),
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0),
            moviePosterImageView.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0),

            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 1.0.responsiveW),
            movieTitleLabel.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0),
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -1.0.responsiveW),
            movieTitleLabel.widthAnchor.constraint(equalToConstant: 80.0.responsiveW)
         ]
    }
}

// MARK: - Layout changes
extension MovieCollectionViewCell {
    
    private func changeCellLayout() {
        moviePosterImageView.removeFromSuperview()
        contentUIView.addSubview(moviePosterImageView)
        
        movieTitleLabel.removeFromSuperview()
        contentUIView.addSubview(movieTitleLabel)
        
        switch layoutType {
        case .list:
            NSLayoutConstraint.deactivate(gridLayoutConstaints)
            NSLayoutConstraint.activate(listLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 10
        case .grid:
            NSLayoutConstraint.deactivate(listLayoutConstaints)
            NSLayoutConstraint.activate(gridLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 15
        }
        
        movieTitleLabel.layoutIfNeeded()
        moviePosterImageView.layoutIfNeeded()
        contentUIView.layoutIfNeeded()
    }
}
