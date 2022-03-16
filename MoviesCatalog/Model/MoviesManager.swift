//
//  MoviesManager.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import Foundation

protocol MoviesManagerDelegate { //I used protokols and Delegates to Carrier data between of the screens.
    func getMovies(_ modelManager : MoviesManager , _ moviesModel : [MoviesModel])
}

struct MoviesManager {
    
    var delegate : MoviesManagerDelegate?

    let baseURL = "https://api.themoviedb.org/3/discover/movie?api_key=7076d78fbdba03fb70e8f147d3fb09a4&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    
    mutating func getMoviesData()   {
        let urlString = baseURL
        performRequest(with: urlString)
    }
    
    func performRequest(with UrlString : String) {
        if let url = URL(string: UrlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if  error != nil  {
                    print("Error")
                    return
                }
                if let moviesData = data {
                    if let movies =  self.parseJson(moviesData){
                        self.delegate?.getMovies(self, movies)
                    }
                }
            }
            task.resume()
        }
    }
                   
    func parseJson(_ data: Data) -> [MoviesModel]? {
        let decoder = JSONDecoder()
        var arrayMovies = [MoviesModel]()
        do{
            let decodedData = try decoder.decode(MoviesData.self, from: data)
            for item in decodedData.results{
                
                let movieName = item.original_title
                let movieDate = item.release_date
                let movieOverview = item.overview
                let movieImageUrl = item.poster_path
            
                arrayMovies.append(MoviesModel(original_title: movieName, release_date: movieDate, poster_path: movieImageUrl, overview: movieOverview))
            }
            return arrayMovies
           
        }
        catch{
           print("Error!")
          return nil
        }
    }
    
    
}

