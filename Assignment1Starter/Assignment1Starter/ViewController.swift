//
//  ViewController.swift
//  Assignment1Starter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  // 1. create a mainView
  let mainView: UIView = GreenView()
  
  var activeConstraints: [NSLayoutConstraint] = [] {
    willSet {
      NSLayoutConstraint.deactivate(activeConstraints)
    }
    didSet {
      NSLayoutConstraint.activate(activeConstraints)
    }
  }
  
  fileprivate func createButton(title: String, fontSize: CGFloat) -> UIButton {
    let butt = UIButton(type: .system)
    butt.setTitle(title, for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
    return butt
  }
  
  fileprivate func setupLayout() {
    view.addSubview(mainView)
    // set constraints for mainView (x, y, w, h)
    mainView.alignCenter(to: view)
    activeConstraints = [mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                         mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)]
    
    let squareButt: UIButton = createButton(title: "Square", fontSize: 14)
    squareButt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
    let portraitButt: UIButton = createButton(title: "Portrait", fontSize: 14)
    portraitButt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
    let landscapeButt: UIButton = createButton(title: "Landscape", fontSize: 14)
    landscapeButt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
    
    // 3. create a stackView
    let buttStackView = UIStackView(arrangedSubviews: [squareButt, portraitButt, landscapeButt])
    buttStackView.translatesAutoresizingMaskIntoConstraints = false
    buttStackView.axis = .horizontal
    buttStackView.distribution = .fillEqually
    buttStackView.alignment = .center
    
    view.addSubview(buttStackView)
    // 4. setup constraints for the stackView (center horizontally, pinned to bottom, set width & height)
    NSLayoutConstraint.activate([
      buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
      buttStackView.heightAnchor.constraint(equalToConstant: 50),
      ])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupLayout()
  }
  
  @objc private func squareTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.activeConstraints = [self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)]
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func portraitTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.activeConstraints = [
        self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
        self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
      ]
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func landscapeTapped() {
    // 5. animate mainView (landscape)
    //   - change width, height constraint (w: 95 % w, h: 40 % h)
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.activeConstraints = [
        self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
        self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
      ]
      self.view.layoutIfNeeded()
    }
  }
}
