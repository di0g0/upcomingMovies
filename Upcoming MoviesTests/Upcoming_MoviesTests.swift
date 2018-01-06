//
//  Upcoming_MoviesTests.swift
//  Upcoming MoviesTests
//
//  Created by  Diogo Costa on 29/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import XCTest
@testable import Upcoming_Movies
//TODO: Add networking mock stubs
class GenreTests: XCTestCase {
    func testParseGenre() {
        let genreJson: JSONObject = [
            Constants.ResponseParams.id: 28,
            Constants.ResponseParams.name: "Action"
        ]
        let genre = Genre.fromJson(jsonObject: genreJson)
        XCTAssertNotNil(genre)
        XCTAssertEqual(genre!.name, "Action")
        XCTAssertEqual(genre!.identifier,28)
    }
}

class MovieTests : XCTestCase {
    let movieJson : JSONObject = [
        "vote_count": 6618,
        "id": 238,
        "video": false,
        "vote_average": 8.5,
        "title": "The Godfather",
        "popularity": 76.638749,
        "poster_path": "/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg",
        "original_language": "en",
        "original_title": "The Godfather",
        "genre_ids": [
            18,
            80
        ],
        "backdrop_path": "/6xKCYgH16UuwEGAyroLU6p8HLIn.jpg",
        "adult": false,
        "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
        "release_date": "1972-03-14"
    ]
    
    func testParseMovie() {
        let movie = Movie.fromJson(jsonObject: movieJson)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie!.identifier, 238)
        XCTAssertEqual(movie!.title, "The Godfather")
        XCTAssertEqual(movie!.genreIds, [18,80])
    }
    func testMovieViewModel() {
        let movie = Movie.fromJson(jsonObject: movieJson)
        XCTAssertNotNil(movie)
        let movieViewModel = MovieViewModel(movie: movie!)
        XCTAssertNotNil(movieViewModel)
        XCTAssertEqual(movieViewModel.title, "The Godfather")
    }
    
    func testGetUpcomingMovies() {
        let testExpectation = expectation(description: "Test getting upcoming Movies")
        
        let listViewModel = MovieListViewModel()
        listViewModel.onMoviesUpdated = {
            dump(listViewModel.movies)
            XCTAssert(listViewModel.movies.count > 0)
            testExpectation.fulfill()
        }
        listViewModel.updateMovies()
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
