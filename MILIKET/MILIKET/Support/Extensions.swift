//
//  Extensions.swift
//  TrakingMe
//
//  Created by Thành Lã on 12/30/16.
//  Copyright © 2016 Bình Anh Electonics. All rights reserved.
//


import UIKit
import RealmSwift
import GoogleMaps
import PHExtensions

extension Results {
    func toArray() -> [Results.Iterator.Element] {
        return Array(self)
    }
}

extension GMSPath {
    
    var coordinates: [CLLocationCoordinate2D] {
        return (0..<self.count()).map { self.coordinate(at: $0) }
    }
}

extension Double {
    var toKmh: Double {
        return self * 3.6
    }
    
    var toHours: Double {
        return self / 3_600
    }
}

extension UIView {
    func addShadow(with color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
