//
//  MovieDetailViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 14/11/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    
    @IBOutlet weak var movieSummary: UITextView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    var idHolder:Int = 0
    var nameHolder:String = ""
    var ratingHolder:String = ""
    var genreHolder:String = ""
    var imageHolder:String = ""
    var summaryHolder:String = ""
    
    var network = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieName.text = nameHolder
        movieRating.text = ratingHolder
        movieGenre.text = genreHolder
        movieImage.loadImage(urlString: imageHolder)
        movieSummary.text = summaryHolder
        
        tableView.delegate = self
        tableView.dataSource = self
       
        network.fetchShowCast(showID: idHolder) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        // Do any additional setup after loading the view.
    }

}

extension MovieDetailViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension MovieDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.movieCastArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieDetailTableViewCell
        
        cell.actorImage.loadImage(urlString: network.movieCastArr[indexPath.row].person.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        cell.actorName.text = network.movieCastArr[indexPath.row].person.name
        return cell
    }
    
    
}
