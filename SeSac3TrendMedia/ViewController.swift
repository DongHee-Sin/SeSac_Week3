//
//  ViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    // 언제 아웃렛컬렉션을 사용하는 것이 좋을까?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    
    // 변수의 스코프
    // 여기있는 format은 VC에서 항상 사용하는데
    // 함수의 스코프 내부에서 사용하면 함수가 호출될 때마다 메모리에 올라갔다 내려가는데
    // 비효율적일 수 있다.
    // 상황에 따라 다르겠지만 지금 구현된 코드에서는 이게 더 효율적일 수 있다.
    let format = DateFormatter()
    
    
    
    @IBOutlet weak var yellowViewLeadingConstrant: NSLayoutConstraint!
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 형식도 고정이라면 초기 세팅에서 설정해주면 좋을 수 있다.
        format.dateFormat = "yyyy/MM/dd"
        
        yellowViewLeadingConstrant.constant = 120
    }


    func contigureLabelDesign() {
        // 1. OutletCollection을 사용하는 방법 (ex. UIView - 단순 UI설정을 동일하게 가져가고 싶은 경우)
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        
        // OutletCollection의 Index를 사용하는 이 방법은 좋지 않을 수 있음
        // 한참뒤에 확인했을 때 뭐가 뭘 표현하는지 구분하기 어려울 수 있고
        // Label이 추가되거나 중간에 하나가 삭제될 때 수정하기 어려워질 수 있다.
        dateLabelCollection[0].text = "첫번쨰 텍스트"
        dateLabelCollection[1].text = "두번쨰 텍스트"
        
        
        
        // 2. UILabel 배열을 만들어서 사용하는 방법
        // 배열을 만들어서 공통되는 부분들을 설정해주고
        // 서로 다른 내용들은 번거롭더라도 직접 데이터를 주는게 좋다.
        let labelArray = [dateLabel, date2Label]
        for i in labelArray {
            i?.font = .boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
        
        dateLabel.text = "첫번쨰 텍스트"
        date2Label.text = "두번쨰 텍스트"
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = format.string(from: sender.date)
        
    }
    
}

