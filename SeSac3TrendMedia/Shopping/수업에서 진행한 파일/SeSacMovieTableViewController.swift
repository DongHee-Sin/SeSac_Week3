//
//  SeSacMovieTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/20.
//

import UIKit

class SeSacMovieTableViewController: UITableViewController {

    // MARK: - Propertys
    var movieList = MovieInfo()
    //["암살", "내 머릿속의 지우개", "라이언 일병 구하기", "라라랜드", "기묘한 이야기"]
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    // MARK: - Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeSacMovieTableViewCell", for: indexPath) as! SeSacMovieTableViewCell
    
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
}
