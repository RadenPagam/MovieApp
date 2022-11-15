//
//  ActorListViewController.swift
//  movieApp
//
//  Created by Dimas Pagam on 13/11/22.
//

import UIKit

class ActorListViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        network.fetchActor {
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
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ActorSearch") as? ActorSearchViewController{
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

extension ActorListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ActorDetail") as? ActorDetailViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            vc.idHolder = network.actorArr[indexPath.row].id
            vc.nameHolder = network.actorArr[indexPath.row].name
            if let age = network.actorArr[indexPath.row].birthday{
                vc.ageHolder = "\(age)"
            }else{
                vc.ageHolder = "-"
            }
            if let gender = network.actorArr[indexPath.row].gender{
                vc.genderHolder = gender
            }else{
                vc.genderHolder = "None"
            }
            vc.imageHolder = network.actorArr[indexPath.row].image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png"
            if let nationality = network.actorArr[indexPath.row].country?.name{

                vc.nationHolder = nationality
            }else{
                vc.nationHolder = "None"
            }
            
        }
    }
}

extension ActorListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.actorArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActorListTableViewCell
        cell.actorImage.loadImage(urlString: network.actorArr[indexPath.row].image?.original ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png")
        cell.actorName.text = network.actorArr[indexPath.row].name
        cell.actorAge.text = network.actorArr[indexPath.row].gender ?? "Data Not Found"
        cell.actorGender.text = network.actorArr[indexPath.row].birthday ?? "Data Not Found"
        
        return cell
    }
    
    
}
