//
//  ArtistSearchViewController.swift
//  MVVMPractice
//
//  Created by Charles Kang on 12/5/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import UIKit

class ArtistSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [Artist] = []
    
    func search(artist: String?) {
        guard let artist = artist else {
            return
        }
        reset()
        let urlEncodedArtist = artist.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url: URL = URL(string: "https://api.spotify.com/v1/search?q=\(urlEncodedArtist)&type=artist")!
        print(url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                if let artists = json?["artists"]?["items"] as? [AnyObject] {
                    if artists.isEmpty {
                    } else {
                        for artist in artists {
                            let artist = Artist(artist: artist as! [String : AnyObject])
                            self.searchResults.append(artist)
                        }
                        
                        OperationQueue.main.addOperation {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                return
            }
        }
        task.resume()
    }
    
    func reset() {
        searchResults = []
        tableView.reloadData()
    }

}

extension ArtistSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCellIdentifier", for: indexPath)
        let artist = searchResults[indexPath.row]
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.genres
        
        return cell
    }
}

extension ArtistSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        search(artist: searchBar.text)
    }

}
