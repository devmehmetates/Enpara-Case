//
//  MovieDetailsViewModel.swift
//  EnparaCase
//
//  Created by Mehmet Ateş on 10.08.2022.
//

protocol MovieDetailsViewModel { }

// MARK: - Network
extension MovieDetailsViewModel {
    
    func getMovies(byId id: Int, movie: @escaping (_ movie: Movie) -> Void) {
        NetworkManager<MockModel>.apiRequest(NetworkConstants.requestPathWithEndpoint("\(id)")) { response in
            switch response {
                
            case .success((let data, let code)):
                guard let movieData: Movie = data.toModel() else { return }
                guard code == 200 else { return }
                return movie(movieData)
            case .failure:
                print("Error")
            }
        }
    }
}
