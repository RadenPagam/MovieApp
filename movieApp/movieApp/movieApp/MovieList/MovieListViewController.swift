//
//  MovieListViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 13/11/22.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    var nameHolder:String = ""
    var network = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //print("MoviePage: \(nameHolder)")
//        network.fetchShow(searchResult: nameHolder) {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        network.fetchShow {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func searchBtn(_ sender: UIButton) {
        if textField.text != nil{
            print(textField.text!)
            var result = textField.text!
            var resultChange = result.replacingOccurrences(of: " ", with: "%20")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieSearch") as? MovieSearchViewController{
                self.navigationController?.pushViewController(vc, animated: true)
                vc.nameHolder = resultChange
                vc.titleHolder = result
                textField.text = ""
            }
        }else{
            print("please insert Movie Name")
        }
    }
    
}

extension MovieListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? MovieDetailViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            vc.idHolder = network.showArr[indexPath.row].id
            vc.nameHolder = network.showArr[indexPath.row].name
            if let rating = network.showArr[indexPath.row].rating.average{
                vc.ratingHolder = "\(rating)"
            }else{
                vc.ratingHolder = "-"
            }
            if let genre = network.showArr[indexPath.row].genres{
                let genreString = genre.joined(separator: ",")
                vc.genreHolder = genreString
            }else{
                vc.genreHolder = "None"
            }
            vc.imageHolder = network.showArr[indexPath.row].image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png"
            if let summary = network.showArr[indexPath.row].summary{
                var summaryFix = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                vc.summaryHolder = summaryFix
            }else{
                vc.summaryHolder = "None"
            }
            
        }
    }
}

extension MovieListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.showArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        cell.movieTitle.text = network.showArr[indexPath.row].name
        cell.movieImage.loadImage(urlString: network.showArr[indexPath.row].image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        var scoreReview = ""
        if network.showArr[indexPath.row].rating.average != nil{
            scoreReview = "Rating: \(network.showArr[indexPath.row].rating.average!)"
        }else{
            scoreReview = "Rating: is yet To Be Determine"
        }
        cell.movieRating.text = scoreReview
        let genre = network.showArr[indexPath.row].genres ?? ["Not","Yet","Determined"]
        let genreString = genre.joined(separator: ",")
        cell.movieGenre.text = genreString

        return cell
    }
    
    
}
