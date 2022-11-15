//
//  MovieSearchViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 14/11/22.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var nameHolder:String = ""
    var titleHolder:String = ""
    var network = NetworkManager()
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchTitle.text = "Search: \(titleHolder)"
        tableView.delegate = self
        tableView.dataSource = self
       
        network.fetchSearchShow(searchResult: nameHolder) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        print(nameHolder)
    }
    
}

extension MovieSearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? MovieDetailViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            vc.idHolder = network.showListArray[indexPath.row].show.id
            vc.nameHolder = network.showListArray[indexPath.row].show.name
            if let rating = network.showListArray[indexPath.row].show.rating.average{
                vc.ratingHolder = "\(rating)"
            }else{
                vc.ratingHolder = "-"
            }
            if let genre = network.showListArray[indexPath.row].show.genres{
                let genreString = genre.joined(separator: ",")
                vc.genreHolder = genreString
            }else{
                vc.genreHolder = "None"
            }
            vc.imageHolder = network.showListArray[indexPath.row].show.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png"
            if let summary = network.showListArray[indexPath.row].show.summary{
                var summaryFix = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                vc.summaryHolder = summaryFix
            }else{
                vc.summaryHolder = "None"
            }
            
        }
    }
}

extension MovieSearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.showListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieSearchTableViewCell
        cell.movieTitle.text  = network.showListArray[indexPath.row].show.name
        if let rating = network.showListArray[indexPath.row].show.rating.average{
            cell.movieRating.text = "\(rating)"
        }else{
            cell.movieRating.text = "-"
        }
        if let genre = network.showListArray[indexPath.row].show.genres{
            let genreString = genre.joined(separator: ",")
            cell.movieGenre.text = genreString
        }else{
            cell.movieGenre.text = "None"
        }
        
        
        cell.movieImage.loadImage(urlString: network.showListArray[indexPath.row].show.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        return cell
    }
    
    
}
