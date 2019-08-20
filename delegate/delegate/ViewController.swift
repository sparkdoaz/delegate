//
//  ViewController.swift
//  delegate
//
//  Created by 黃建程 on 2019/8/19.
//  Copyright © 2019 Spark. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    var selectiobView: SelectionView! {
        didSet {
            selectiobView.dataSource = self
            selectiobView.delegate = self
        }
    }
    
    var selectionViewTwo: SelectionView! {
        didSet {
            selectionViewTwo.dataSource = self
            selectionViewTwo.delegate = self
        }
    }
    
    var fake = ["Julia", "呂世軒", "熊仔", "街巷", "LeoWang"]
    var fakeTwo = ["kkbox", "spotify", "AppleMusic"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //safearea
        self.selectiobView = SelectionView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 100))
        selectionViewTwo = SelectionView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 100))
        self.view.addSubview(selectiobView)
        self.view.addSubview(selectionViewTwo)
        self.selectionViewTwo.delegate = self
        self.selectiobView.delegate = self
        self.selectionViewTwo.dataSource = self
        self.selectiobView.dataSource = self
        //一開始只有寫didset 不會有數字跳出來
        
        view.backgroundColor = .black
    }


}

extension ViewController: SelectionViewDelagate {
    func didSelected(_ selectionView: SelectionView, index: Int) {
        print(index)
//        switch selectionView {
//        case selectiobView:
//            <#code#>
//        default:
//
//        }
    
    }
    
    func isCanChoose(_ selectionView: SelectionView, index: Int) -> Bool {
        switch selectionView {
        case selectiobView:
            return true
            
        case selectionViewTwo:
            
            if selectiobView.selectedIndex == fake.count - 1 {
                
                return false
            }
            return true
        default:
            return true
        }
    }
}

extension ViewController: SelectionViewDataSource {
    
    
    func colorOfEachText(_ selectionView: SelectionView) -> UIColor {
        switch selectionView {
        case self.selectiobView:
            return .white
        case  self.selectionViewTwo:
            return .white
        default:
            return .brown
        }
    }
    
    func textOfEachButton(_ selectionView: SelectionView, index: Int) -> String {
        switch selectionView {
        case selectiobView:
            return fake[index]
        case selectionViewTwo:
            return fakeTwo[index]
        default:
            return ""
        }
    }
    
    func numberOfButton(in selectionView: SelectionView) -> Int {
        switch selectionView {
        case selectiobView:
            return fake.count
        case selectionViewTwo:
            return fakeTwo.count
        default:
            return 2
        }
    }
    
    
    
    
}

