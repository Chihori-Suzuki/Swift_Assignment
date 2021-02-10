//
//  AnimationViewController.swift
//  Animation_Assignment7
//
//  Created by 鈴木ちほり on 2021/01/14.
//

import UIKit

class AnimationViewController: UIViewController {

//    var navBarStatus = false
    
    let navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xDDDDDD)
        return view
    }()
    let plusBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(pushBtn(_:)), for: .touchUpInside)
        return btn
    }()
    let navStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let snacksLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "SNACKS"
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        return lb
    }()
    
    let selectedImage = ["Oreos", "Pizza Pockets", "Pop Tarts", "Popsicle", "Ramen"]
    var items = [String]()
    let cellId = "Cells"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(navBar)
        view.addSubview(plusBtn)
        
        view.addSubview(snacksLabel)
        navStackView.isHidden = true
        navBar.addSubview(navStackView)
        
        setView()
        setStackView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func setView(){

        navBar.heightAnchor.constraint(equalToConstant: 88).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        plusBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5).isActive = true
        plusBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        navStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        navStackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        navStackView.leftAnchor.constraint(equalTo: navBar.leftAnchor).isActive = true
        navStackView.widthAnchor.constraint(equalTo: navBar.widthAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        
        snacksLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        snacksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    func setStackView() {
        let ivOne = UIImageView(image: UIImage(named: "oreos"))
        let ivTwo = UIImageView(image: UIImage(named: "pizza_pockets"))
        let ivThree = UIImageView(image: UIImage(named: "pop_tarts"))
        let ivFour = UIImageView(image: UIImage(named: "popsicle"))
        let ivFive = UIImageView(image: UIImage(named: "ramen"))
        let imageViews = [ivOne, ivTwo, ivThree, ivFour, ivFive]
        
        for i in 0..<imageViews.count {
            imageViews[i].isUserInteractionEnabled = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageViews[i].addGestureRecognizer(tapGestureRecognizer)
            imageViews[i].tag = i
            navStackView.addArrangedSubview(imageViews[i])
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        print("image tapped")
        if let i = tapGestureRecognizer.view?.tag {
            items.append(selectedImage[i])
            let indexPath = IndexPath(row: items.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func pushBtn(_ sender: UIButton) {
        if navStackView.isHidden {
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.navStackView.isHidden = false
                let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 3.5)
                self.navBar.transform = scaleTransform
                _ = CGAffineTransform(translationX: self.view.frame.size.width / 2 - 50, y: self.view.frame.size.height / 2 - 50)
                self.plusBtn.transform = CGAffineTransform(rotationAngle: .pi/4)
                self.view.layoutIfNeeded()
                self.tableView.contentInset = UIEdgeInsets(top: self.navBar.bounds.height + 15, left: 0, bottom: 0, right: 0)
                self.snacksLabel.text = "Add a SNACK"
                self.snacksLabel.transform = CGAffineTransform(translationX: 0, y: 40)
            }, completion: nil)
        } else {
            self.navStackView.isHidden = true
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.navBar.transform = .identity
                self.plusBtn.transform = .identity
                self.view.layoutIfNeeded()
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self.snacksLabel.text = "SNACKS"
                self.snacksLabel.transform = .identity
            }, completion: nil)
            
        }
    }
}

extension AnimationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xDD,
           green: (rgb >> 8) & 0xDD,
           blue: rgb & 0xDD
       )
   }
}

