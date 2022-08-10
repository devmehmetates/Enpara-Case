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
    
    func setMoviePoster(withPosterPath path: String) {
        guard let posterSource = URL(string: path) else { return }
        moviePosterImageView.kf.setImage(with: posterSource)
    }
    
    func setMovieTitleLabel(withTitle title: String?) {
        movieTitleLabel.text = title
        configureContents()
    }
    
    func setCellLayoutTpye(withLayoutType layoutTpye: LayoutType) {
        self.layoutType = layoutTpye
    }
    
    private func changeCellLayout() {
        moviePosterImageView.removeFromSuperview()
        contentUIView.addSubview(moviePosterImageView)
        
        movieTitleLabel.removeFromSuperview()
        contentUIView.addSubview(movieTitleLabel)
        
        switch layoutType {
            
        case .list:
            NSLayoutConstraint.activate(listLayoutConstaints)
            NSLayoutConstraint.deactivate(gridLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 10
        case .grid:
            NSLayoutConstraint.activate(gridLayoutConstaints)
            NSLayoutConstraint.deactivate(listLayoutConstaints)
            
            self.contentUIView.layer.cornerRadius = 15
        }
        
        movieTitleLabel.updateConstraintsIfNeeded()
        moviePosterImageView.updateConstraintsIfNeeded()
        movieTitleLabel.layoutIfNeeded()
        moviePosterImageView.layoutIfNeeded()
    }
    
    private func configureContents() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(gridLayoutConstaints)
        
        self.contentUIView.layer.cornerRadius = 15
        self.contentUIView.layer.masksToBounds = true
    }
}
