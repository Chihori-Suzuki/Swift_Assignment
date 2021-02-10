//
//  Item.swift
//  Restaurant_Ass8
//
//  Created by 鈴木ちほり on 2021/02/08.
//

import Foundation

enum Item: Hashable {
    
    case header(Header)
    case main(Main)
    
    var header: Header? {
        if case .header(let header) = self {
            return header
        } else {
            return nil
        }
    }
    
    var main: Main? {
        if case .main(let main) = self {
            return main
        } else {
            return nil
        }
    }
    
    static let headerList: [Item] = [
        .header(Header(name: "Asian")),
        .header(Header(name: "Mexican")),
        .header(Header(name: "American")),
        .header(Header(name: "Mediterranean")),
        .header(Header(name: "Breakfast")),
        .header(Header(name: "Lunch")),
        .header(Header(name: "Dinner"))
    ]
    
    static let restaurantList: [Item] = [
        .main(Main(title: " Yamato Sushi", subTitle: " Lunch, Dinner, Asian", imageName: "Yamato.jpg")),
        .main(Main(title: " El Guapo", subTitle: " Dinner, Mexican", imageName: "ElGuapo.jpg")),
        .main(Main(title: " Flying Pig", subTitle: " Lunch, Dinner, American", imageName: "FlyingPig.jpg")),
        .main(Main(title: " Jam Cafe", subTitle: " Breakfast, American", imageName: "Jam.jpg")),
        .main(Main(title: " StePho's", subTitle: " Dinner, Mediterranean", imageName: "Stepho.jpg")),
        .main(Main(title: " Keg Stake House", subTitle: " Dinner, American", imageName: "Keg.jpg")),
        .main(Main(title: " Pho Central", subTitle: " Lunch, Dinner, Asian", imageName: "PhoCentral.jpg")),
        .main(Main(title: " Sura Korean Cusin", subTitle: " Lunch, Dinner, Korean", imageName: "Sura.jpg")),
        .main(Main(title: " Cafe Orange", subTitle: " Lunch, Dinner, Asian", imageName: "Orange.jpg")),
        .main(Main(title: " Nuba", subTitle: " Lunch, Dinner, Mediterranean", imageName: "Nuba.jpg")),
        .main(Main(title: " Chipotle", subTitle: " Lunch, Dinner, Mexican", imageName: "Chipotle.jpg")),
    ]
    
    
}
