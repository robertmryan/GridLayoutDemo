//
//  ViewController.swift
//  GridLayoutDemo
//
//  Created by Robert Ryan on 8/6/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

struct CustomObject {
    let text: String
    let color: UIColor
}

class ViewController: UICollectionViewController {

    lazy var objects: [CustomObject] = (0 ..< 15).map { self.randomObject(with: "\($0)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            let indexPath = IndexPath(item: self.objects.count, section: 0)
            self.objects.append(self.randomObject(with: "New \(indexPath.item)"))
            self.collectionView?.insertItems(at: [indexPath])

            if self.objects.count > 27 { timer.invalidate() }
        }
    }
    
    private func randomObject(with string: String) -> CustomObject {
        let color = UIColor(red: CGFloat(arc4random_uniform(128)) / 255,
                       green: CGFloat(arc4random_uniform(128)) / 255,
                       blue: CGFloat(arc4random_uniform(128)) / 255,
                       alpha: 1)
        return CustomObject(text: string, color: color)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let object = objects[indexPath.item]
        cell.label.text = object.text
        cell.backgroundColor = object.color
        return cell
    }

}

