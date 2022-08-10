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

// swiftlint: disable all
// MARK: - Constraint
extension MovieCollectionViewCell {
    
    // MARK: Grid
    var moviePosterGridTopConstraint: NSLayoutConstraint { moviePosterImageView.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0) }
    var moviePosterGridTrailingConstraint: NSLayoutConstraint { moviePosterImageView.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: 0) }
    var moviePosterGridLeadingConstraint: NSLayoutConstraint {  moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0) }
    var moviePosterGridHeightConstraint: NSLayoutConstraint {  moviePosterImageView.heightAnchor.constraint(equalToConstant: 60.0.responsiveW) }
    
    var movieTitleLabelGridTopConstraint: NSLayoutConstraint { movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 1.0.responsiveW) }
    var movieTitleLabelGridTrailingConstraint: NSLayoutConstraint { movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -1.0.responsiveW) }
    var movieTitleLabelGridLeadingConstraint: NSLayoutConstraint { movieTitleLabel.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 1.0.responsiveW) }
    var movieTitleLabelGridBottomConstraint: NSLayoutConstraint { movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: -1.0.responsiveW) }
    
    private var gridLayoutConstaints: [NSLayoutConstraint] {
         [
            moviePosterGridTopConstraint,
            moviePosterGridTrailingConstraint,
            moviePosterGridLeadingConstraint,
            moviePosterGridHeightConstraint,
            movieTitleLabelGridTopConstraint,
            movieTitleLabelGridTrailingConstraint,
            movieTitleLabelGridLeadingConstraint,
            movieTitleLabelGridBottomConstraint
         ]
    }
    
    // MARK: List
    var moviePosterListTopConstraint: NSLayoutConstraint { moviePosterImageView.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0) }
    var moviePosterListLeadingConstraint: NSLayoutConstraint { moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0) }
    var moviePosterListBottomConstraint: NSLayoutConstraint { moviePosterImageView.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0) }
    var moviePosterListWidthConstraint: NSLayoutConstraint { moviePosterImageView.widthAnchor.constraint(equalToConstant: 30.0.responsiveW) }
    
    var movieTitleLabelListLeadingConstraint: NSLayoutConstraint { movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 1.0.responsiveW) }
    var movieTitleLabelListTopConstraint: NSLayoutConstraint { movieTitleLabel.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0) }
    var movieTitleLabelListBottomConstraint: NSLayoutConstraint { movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0) }
    var movieTitleLabelListTrailingConstraint: NSLayoutConstraint { movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -1.0.responsiveW) }
    
    private var listLayoutConstaints: [NSLayoutConstraint] {
         [
            moviePosterListTopConstraint,
            moviePosterListLeadingConstraint,
            moviePosterListBottomConstraint,
            moviePosterListWidthConstraint,
            movieTitleLabelListLeadingConstraint,
            movieTitleLabelListTopConstraint,
            movieTitleLabelListBottomConstraint,
            movieTitleLabelListTrailingConstraint
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
            moviePosterImageView.removeConstraint(moviePosterGridTrailingConstraint)
            moviePosterImageView.removeConstraint(moviePosterGridHeightConstraint)
            NSLayoutConstraint.deactivate(gridLayoutConstaints)
            NSLayoutConstraint.activate(listLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 10
        case .grid:
            moviePosterImageView.removeConstraint(moviePosterListWidthConstraint)
            moviePosterImageView.removeConstraint(moviePosterListBottomConstraint)
            NSLayoutConstraint.deactivate(listLayoutConstaints)
            NSLayoutConstraint.activate(gridLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 15
        }
        
        movieTitleLabel.layoutIfNeeded()
        moviePosterImageView.layoutIfNeeded()
        contentUIView.layoutIfNeeded()
    }
}
