//
//  RecommendCollectionViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

class RecommendCollectionViewController: UICollectionViewController {

    var imageURL = "https://movie-phinf.pstatic.net/20220720_283/1658284839003UzxoT_JPEG/movie_image.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Flow Layout -> 전통적인 방법
        // 컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정 필요
        // 일반적으로 비율을 통해 잡음
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8  // 공통적으로 사용할 리터럴값은 상수로 저장해두고 사용하면 좋다.
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        
        // Compositional Layout 방식도 있다. -> 이건 최근에 나온거
    }
    
    /*
     TablaView -> CollectionView
     Row -> Item
     heightForRowAt -> FlowLayout (heightForItemAt이 없는 이유 : width값도 필요함)
    */

    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    // cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.posterImageView.backgroundColor = .orange
        
        let url = URL(string: imageURL)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
    // didSelectItemAt -> 테이블뷰는 didSelectedRowAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 1, position: .bottom)
        
        self.navigationController?.popViewController(animated: true)
    }
}
