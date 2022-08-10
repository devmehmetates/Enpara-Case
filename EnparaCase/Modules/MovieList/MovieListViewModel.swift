//
//  MovieListViewModel.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 9.08.2022.
//

protocol MovieListViewModel { }

// MARK: - Network
extension MovieListViewModel {
    
    func getMovies(byPage page: Int, movieList: @escaping (_ movieList: [Movie], _ totalPage: Int) -> Void) {
        NetworkManager<MockModel>.apiRequest(NetworkConstants.requestPathWithEndpoint("top_rated", page: page)) { response in
            switch response {
                
            case .success((let data, let code)):
                guard let movies: Movies = data.toModel() else { return }
                guard code == 200 else { return }
                return movieList(movies.results ?? [], movies.totalPages ?? 1)
            case .failure:
                print("Error")
            }
        }
    }
}
