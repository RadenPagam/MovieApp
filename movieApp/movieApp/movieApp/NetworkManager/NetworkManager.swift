//
//  NetworkManager.swift
//  movieApp
//
//  Created by Dimas Pagam on 13/11/22.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    //MARK: get searchshow api
    var showListArray: [ShowList] = []
    func fetchSearchShow(searchResult:String, onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/search/shows?q=\(searchResult)"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do{
                self.showListArray = try JSONDecoder().decode([ShowList].self, from: data!)
                print("returned data:\(self.showListArray)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
    
    //MARK: show list API
    var showArr:[Show] = []
    func fetchShow(onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/shows"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do{
                self.showArr = try JSONDecoder().decode([Show].self, from: data!)
                print("returned data:\(self.showArr)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
    
    //MARK: Fetch ActorList API
    var actorArr:[Person] = []
    func fetchActor(onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/people"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do{
                self.actorArr = try JSONDecoder().decode([Person].self, from: data!)
                print("returned data:\(self.actorArr)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
    
    //MARK: fetch search actor
    var ActorListArray: [PersonList] = []
    func fetchSearchActor(searchResult:String, onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/search/people?q=\(searchResult)"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do{
                self.ActorListArray = try JSONDecoder().decode([PersonList].self, from: data!)
                print("returned data:\(self.ActorListArray)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
    
    //MARK: Fetch Movie cast API
    var movieCastArr:[ShowCastElement] = []
    func fetchShowCast(showID:Int,onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/shows/\(showID)/cast"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do{
                self.movieCastArr = try JSONDecoder().decode([ShowCastElement].self, from: data!)
                print("returned data:\(self.movieCastArr)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
    
    
    //MARK: Fetch Actor Credit API
    var ActorCredArr:[ActorCreditElement] = []
    func fetchActorCred(actorID:Int,onCompletion: @escaping ()->()){
        let urlString = "https://api.tvmaze.com/people/\(actorID)/castcredits?embed=show"
        print("accesing url \(urlString)")
        guard let url = URL(string: urlString) else{
            print("CAN NOT create URL From \(urlString)")
            onCompletion()
            return
        }
        //create URL SESSION
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {( data, resp, error )in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            guard let data = data else{
                print("data nil")
                return
            }
            
            do{
                self.ActorCredArr = try JSONDecoder().decode([ActorCreditElement].self, from: data )
                print("returned data:\(self.ActorCredArr)")
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            onCompletion()
        }
        task.resume()
    }
}
