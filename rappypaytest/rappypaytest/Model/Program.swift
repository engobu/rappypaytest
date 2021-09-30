//
//  Program.swift
//  rappypaytest
//
//  Created by Enar GoMez on 25/09/21.
//

import Foundation

class Program: NSObject {

    var backdropPath:String = ""
    var genreIds: [Int] = [Int]()
    var id: Int = -1
    var originalLanguage: String = ""
    var overview: String = ""
    var popularity: Double = 0.0
    var posterPath: String = ""
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    
    //movies
    var adult:Bool = false
    var originalTitle: String = ""
    var releaseDate: String = ""
    var title: String = ""
    var video: Bool = false
    
    //tv
    var firstAirDate: String = ""
    var name: String = ""
    var originCountry:[String] = [String]()
    var originalName: String = ""
    
    var arrVideo: [Video] = [Video]()
    
    override init() {
        
    }
    
    init(backdropPath:String, genreIds: [Int], id: Int, originalLanguage: String, overview: String, popularity: Double, posterPath: String, voteAverage: Double, voteCount: Int, adult:Bool, originalTitle: String, releaseDate: String, title: String, video: Bool, firstAirDate: String, name: String = "", originCountry: [String], originalName: String){
        super.init()
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.firstAirDate = firstAirDate
        self.name = name
        self.originCountry = originCountry
        self.originalName = originalName
    }
    
    convenience init(dicProgram: NSDictionary) {
        
        let backdropPath = dicProgram["backdrop_path"] as? String ?? ""
        
        let id = dicProgram["id"] as? Int ?? -1
        let originalLanguage = dicProgram["original_language"] as? String ?? ""
        let overview = dicProgram["overview"] as? String ?? ""
        let popularity = dicProgram["popularity"] as? Double ?? 0.0
        let posterPath = dicProgram["poster_path"] as? String ?? ""
        let voteAverage = dicProgram["vote_average"] as? Double ?? 0.0
        let voteCount = dicProgram["vote_count"] as? Int ?? 0
        let adult = dicProgram["adult"] as? Bool ?? false
        let originalTitle = dicProgram["original_title"] as? String ?? ""
        let releaseDate = dicProgram["release_date"] as? String ?? ""
        let title = dicProgram["title"] as? String ?? ""
        let video = dicProgram["video"] as? Bool ?? false
        let firstAirDate = dicProgram["first_air_date"] as? String ?? ""
        let name = dicProgram["name"] as? String ?? ""
        let originCountry = dicProgram["origin_country"] as? NSArray ?? []
        let originalName = dicProgram["original_name"] as? String ?? ""
        let genreIds = dicProgram["genre_ids"] as? NSArray ?? []
        
        self.init(backdropPath:backdropPath, genreIds: genreIds as! [Int], id: id, originalLanguage: originalLanguage, overview: overview, popularity: popularity, posterPath: posterPath, voteAverage: voteAverage, voteCount: voteCount, adult:adult, originalTitle: originalTitle, releaseDate: releaseDate, title: title, video: video, firstAirDate: firstAirDate, name: name, originCountry: originCountry as! [String], originalName: originalName)
    }
    func update(arrVideo: [Video]) {
        self.arrVideo.append(contentsOf: arrVideo)
    }
    func getProgramName(type: ProgramTypeEnum) -> String{
        if type == ProgramTypeEnum.Movie {
            return self.title
        }
        return self.name
    }
    
    func getProgramReleaseDate(type: ProgramTypeEnum) -> String{
        if type == ProgramTypeEnum.Movie {
            return self.releaseDate
        }
        return self.firstAirDate
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")!
    }
}
