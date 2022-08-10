//
//  MovieListViewController.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewModel {

    @IBOutlet private var movieCollectionView: UICollectionView!
    private var layoutType = LayoutType.grid
    private var baseMovies: [Movie] = []
    private var movies: [Movie] = []
    private var currentPage: Int = 1 {
        didSet {
            requestApi()
        }
    }
    private var totalPage: Int?
    
    private let refreshControl = UIRefreshControl()
    private var searchBar: UISearchController = {
        let searchBar = UISearchController()
        searchBar.searchBar.placeholder = "Enter the movie name"
        searchBar.searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
}

// MARK: - Configure Contents
extension MovieListViewController {
    
    private func configureContents() {
        configureCollectionViewDelegate()
        configureCollectionViewDataSource()
        configureSearchBar()
        configureRefreshController()
        self.title = "Top Rated"
        requestApi()
    }
}

// MARK: IBActions
extension MovieListViewController {
    
    @IBAction private func gridListValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            layoutType = .grid
        } else {
            layoutType = .list
        }
        
        movieCollectionView.reloadData()
    }
    
    @IBAction private func loadMoreButtonTapped(_ sender: UIButton) {
        if currentPage != totalPage ?? 1 {
            self.currentPage += 1
        }
    }
}

// MARK: RequestAction
extension MovieListViewController {
    
    private func requestApi() {
        getMovies(byPage: currentPage) { movies, totalPage in
            self.movies += movies
            self.baseMovies += movies
            self.totalPage = totalPage
            self.movieCollectionView.reloadData()
        }
    }
}

// MARK: Refresh
extension MovieListViewController {
    
    private func configureRefreshController() {
        self.movieCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMovieList(_:)), for: .valueChanged)
        self.movieCollectionView.addSubview(refreshControl)
    }
    
    @objc
    private func refreshMovieList(_ sender: Any) {
        movies.removeAll()
        currentPage = 1
        self.refreshControl.endRefreshing()
    }
}

// MARK: - Collection View Delegate and FlowLayout
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func configureCollectionViewDelegate() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.row == movies.count {
            return CGSize(width: 97.0.responsiveW, height: 20.0.responsiveW)
        } else {
            switch layoutType {
            case .list:
                return CGSize(width: 97.0.responsiveW, height: 20.0.responsiveW)
            case .grid:
                return CGSize(width: 46.5.responsiveW, height: 75.0.responsiveW)
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        switch layoutType {
        case .list:
            return UIEdgeInsets(top: 0, left: 1.5.responsiveW, bottom: 10, right: 1.5.responsiveW)
        case .grid:
            return  UIEdgeInsets(top: 0, left: 1.5.responsiveW, bottom: 10, right: 1.5.responsiveW)
        }
    }
}

// MARK: - Collection View DataSource
extension MovieListViewController: UICollectionViewDataSource {
    
    private func configureCollectionViewDataSource() {
        self.movieCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == movies.count || movies.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadMore", for: indexPath)
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movie: Movie = movies[indexPath.row]
        
        cell.setMoviePoster = movie.posterImage
        cell.setmovieTitleLabel = movie.title
        cell.setCellLayoutType = layoutType
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie = movies[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetails")
                as? MovieDetailsViewController else { return }
        detailVC.setMovieId = movie.id
        detailVC.setNavigationTitle = movie.title
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - SearchBar
extension MovieListViewController: UISearchResultsUpdating {

    private func configureSearchBar() {
        self.searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        
        if query.isEmpty {
            movies = baseMovies
        } else {
            movies = baseMovies.filter { $0.title?.lowercased().contains(query.lowercased()) ?? false }
        }
        
        self.movieCollectionView.reloadData()
    }
}

// MARK: - Enums
enum LayoutType {
    case list, grid
}
