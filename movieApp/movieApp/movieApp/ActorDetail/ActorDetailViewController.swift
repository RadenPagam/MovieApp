//
//  ActorDetailViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 15/11/22.
//

import UIKit

class ActorDetailViewController: UIViewController {

    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var actorName: UILabel!
    
    @IBOutlet weak var actorAge: UILabel!
    
    @IBOutlet weak var actorGender: UILabel!
    
    @IBOutlet weak var actorNationality: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var network = NetworkManager()
    
    var idHolder:Int = 0
    var nameHolder:String = ""
    var ageHolder:String = ""
    var genderHolder:String = ""
    var imageHolder:String = ""
    var nationHolder:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actorName.text = nameHolder
        actorAge.text = ageHolder
        actorGender.text = genderHolder
        actorImage.loadImage(urlString: imageHolder)
        actorNationality.text = nationHolder
        
        tableView.dataSource = self
        tableView.delegate = self
        
        network.fetchActorCred(actorID: idHolder) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}


extension ActorDetailViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ActorDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.ActorCredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActorDetailTableViewCell
        cell.movieImage.loadImage(urlString: network.ActorCredArr[indexPath.row].embedded.show.image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        cell.movieName.text = network.ActorCredArr[indexPath.row].embedded.show.name
        return cell
    }
    
    
}
