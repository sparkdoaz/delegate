//
//  SelectionView.swift
//  delegate
//
//  Created by 黃建程 on 2019/8/19.
//  Copyright © 2019 Spark. All rights reserved.
//

import Foundation
import UIKit


class SelectionView: UIView  {
    
    
    weak var delegate: SelectionViewDelagate? {
        didSet {
            
        }
    }
    
    weak var dataSource: SelectionViewDataSource? {
        didSet {
            reload()
            setIndicatorView()
            setColorView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var colors = [UIColor.red, UIColor.yellow, UIColor.blue]
    
    var selectedIndex: Int?
    
    func reload() {
        
        guard let dataSource = dataSource else { return }
        
        guard let delegate = delegate else {return}
        
        let numberOfButton = dataSource.numberOfButton(in: self)
        
        for index in 0 ..< dataSource.numberOfButton(in: self){
            
            let buttonWidth = self.frame.width / CGFloat(numberOfButton)
            let buttonHeight = self.frame.height
            
            let button = UIButton(frame: CGRect(
                x: buttonWidth * CGFloat(index),
                y: 0,
                width: buttonWidth,
                height: buttonHeight))
            
            button.backgroundColor = .black

            
            button.setTitle(
                dataSource.textOfEachButton(self, index: index),
                for: .normal)
            
            button.titleLabel?.font = dataSource.fontOfEachButton(self)
            
            button.setTitleColor(
                dataSource.colorOfEachText(self),
                for: .normal)
            
            button.tag = index
            
            
                
            button.addTarget(self, action: #selector(clickedBtn(sender:)), for: .touchUpInside)
                
            
        
            delegate.didSelected(self, index: index)

            self.addSubview(button)
        }
    }
    
    
    var indicatorView = UIView()
    
    var colorView = UIView()

    func setIndicatorView() {
        
        guard let dataSource = dataSource else { return }
        
        indicatorView.backgroundColor = dataSource.indicatorViewColor(self)
        
        let numberOfButton = dataSource.numberOfButton(in: self)
        let buttonWidth = self.frame.width / CGFloat(numberOfButton)
        
        //height 改了 y 也要改
        indicatorView.frame = CGRect(x: 0, y: self.frame.height - 5 , width: buttonWidth, height: 5)
        self.addSubview(indicatorView)
    }
    
    func setColorView() {
        
        guard let dataSource = dataSource else { return }
        
        let numberOfButton = dataSource.numberOfButton(in: self)
        let buttonWidth = self.frame.width / CGFloat(numberOfButton)
        
        colorView.backgroundColor = .red
        colorView.frame = CGRect(x: 0, y: self.frame.height , width: self.frame.width, height: 50)
        
        self.addSubview(colorView)
    }
    
    @objc func clickedBtn( sender: UIButton) {
        
        selectedIndex = sender.tag
        
        print("selectedIndex: \(selectedIndex)")
        
        guard let delegate = delegate else { return}
        
        if delegate.isCanChoose(self, index: sender.tag) {
            UIView.animate(withDuration: 0.2) {
                self.indicatorView.center.x = sender.center.x
            }
            
            self.colorView.backgroundColor = colors[sender.tag % 3]
            
            //tableview cell 是一個 view 但是雖然不是 button 但是可以用 ui手勢，只要符合手勢就會觸發下面類似的func，就可以做到 didselected 的效果
            delegate.didSelected(self, index: sender.tag)
            
            
            
            print("is:  \(delegate.isCanChoose(self, index: sender.tag))")
        } 
        
        
    }
    
    
}


protocol SelectionViewDelagate: AnyObject {
    
    func didSelected(_ selectionView: SelectionView, index: Int) 
    
    func isCanChoose(_ selectionView: SelectionView, index: Int) -> Bool
}

extension SelectionViewDelagate{
//
//    func didSelected(_ selectionView: SelectionView, index: Int) -> Int {
//        return 0
//    }
//
//
//    func isCanChoose(_ selectionView: SelectionView, index: Int) -> Bool {
//        return true
//    }
}

protocol SelectionViewDataSource: AnyObject  {
    
    func numberOfButton(in selectionView: SelectionView) -> Int
    
    func textOfEachButton(_ selectionView: SelectionView, index: Int ) -> String

    func indicatorViewColor(_ selectionView: SelectionView) -> UIColor

    func fontOfEachButton(_ selectionView: SelectionView) -> UIFont

    func colorOfEachText(_ selectionView: SelectionView) -> UIColor

}
//預設
extension SelectionViewDataSource {
    
    func numberOfButton(in selectionView: SelectionView) -> Int {
        return 2
    }
    
    func colorOfEachText(_ selectionView: SelectionView) -> UIColor {
        return .white
    }
    
    func fontOfEachButton(_ selectionView: SelectionView) -> UIFont {
        return .systemFont(ofSize: 18)
    }
    
    func indicatorViewColor(_ selectionView: SelectionView) -> UIColor {
        return .blue
    }
    
}

