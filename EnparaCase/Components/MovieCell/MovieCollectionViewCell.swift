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
            
            moviePosterImageView.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0).isActive = true
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0).isActive = true
            moviePosterImageView.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0).isActive = true

            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 10).isActive = true
            movieTitleLabel.topAnchor.constraint(equalTo: contentUIView.topAnchor, constant: 0).isActive = true
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: 0).isActive = true
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -10).isActive = true
            movieTitleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        case .grid:
            moviePosterImageView.topAnchor .constraint(equalTo: contentUIView.topAnchor, constant: 0).isActive = true
            moviePosterImageView.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: 0).isActive = true
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0).isActive = true
            
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: -10).isActive = true
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -10).isActive = true
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 10).isActive = true
            movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 10).isActive = true
        }
        
        movieTitleLabel.layoutIfNeeded()
        moviePosterImageView.layoutIfNeeded()
    }
    
    private func configureContents() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        moviePosterImageView.topAnchor .constraint(equalTo: contentUIView.topAnchor, constant: 0).isActive = true
        moviePosterImageView.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: 0).isActive = true
        moviePosterImageView.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 0).isActive = true
        
        movieTitleLabel.bottomAnchor.constraint(equalTo: contentUIView.bottomAnchor, constant: -10).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: contentUIView.trailingAnchor, constant: -10).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: contentUIView.leadingAnchor, constant: 10).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 10).isActive = true
    }
}
