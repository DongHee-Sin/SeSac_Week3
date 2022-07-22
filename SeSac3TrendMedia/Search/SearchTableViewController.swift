//
//  SearchTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let movieModel = MovieInfo()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonTapped))
    }

    
    
    
    // MARK: - Methods
    @objc func resetButtonTapped() {
        // iOS 13+ SceneDelegate를 사용할 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController else {
            return
        }
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel.movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.movieTitleLabel.text = movieModel.movieList[indexPath.row].title
        cell.moviePlotLabel.text = movieModel.movieList[indexPath.row].overview
        cell.releaseDateLabel.text = movieModel.movieList[indexPath.row].releaseDate
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RecommendCollectionViewController") as? RecommendCollectionViewController else {
            return
        }
        
        // 2. vc가 가지고 있는 프로퍼티에 데이터 추가
        vc.movieData = movieModel.movieList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
