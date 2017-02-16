//
//  Image.swift
//  Dang
//
//  Created by Thành Lã on 12/30/16.
//  Copyright © 2016 IOS. All rights reserved.
//

import UIKit
import PHExtensions

extension UIImage {
    /**
     Vẽ ảnh từ text
     */
    class func imageFromText(_ text: String, size: CGSize, textSize: CGFloat = 24, color: UIColor = UIColor.main) -> UIImage {
        
        let data = text.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let drawText = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: FontType.latoSemibold.., size: textSize)!,
                                  NSForegroundColorAttributeName: color]
        
        let widthOfText = Utility.shared.widthForView(text: text, font: UIFont(name: FontType.latoSemibold.., size: textSize)!, height: size.height)
        let heightOfText = Utility.shared.heightForView(text: text, font: UIFont(name: FontType.latoSemibold.., size: textSize)!, width: size.width)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        drawText?.draw(in: CGRect(x: (size.width - widthOfText) / 2, y: (size.height - heightOfText) / 2, width: size.width, height: size.height),
                       withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func tint(_ color:UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.set()
        UIRectFill(rect)
        draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: CGFloat(1.0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}

struct Icon {
    
    struct Home {
        static var SearchHistory = UIImage(named: "SearchHistory")!
        static var Calendar = UIImage(named: "Calendar")!
        static var Time = UIImage(named: "Time")!
        static var Personal = UIImage(named: "Personal")!
        static var VehicleCar = UIImage(named: "VehicleCar")!
        static var Favorite = UIImage(named: "Favorite")!
        static var FavoriteFill = UIImage(named: "FavoriteFill")!
        static var markerCenter = UIImage(named: "MarkerCenter")!
        
    }
    
    struct General {
        static var myLocation = UIImage(named: "MyLocation")!
        static var arrowDown = UIImage(named: "ArrowDown")!
        static var background = UIImage(named: "cover")!
        static var logo = UIImage(named: "logo")!
    }
    
    struct Login {
        static var Person = UIImage(named: "Person")!
        static var Key = UIImage(named: "Key")!
        static var CheckBox = UIImage(named: "CheckBox")!
        static var UncheckBox = UIImage(named: "UncheckBox")!
    }
    
    struct Person {
        static var avatar = UIImage(named: "avatar")!
    }
    
    struct Nav {
        
        static var Menu     = UIImage(named: "Menu")!
        static var Back     = UIImage(named: "Back")!
        static var Done     = UIImage(named: "Done")!
        static var Trash    = UIImage(named: "Trash")!
        static var Delete   = UIImage(named: "Delete")!
        static var Add      = UIImage(named: "Add")!
        static var Filter   = UIImage(named: "Filter")!
        static var Refesh   = UIImage(named: "Refesh")!
        static var Arrow    = UIImage(named: "Arrow")!
        
        static var edit     = UIImage(named: "Edit")!
        static var setting  = UIImage(named: "Setting")!
        static var info     = UIImage(named: "Info")!
    }
    
    struct Marker {
        static var active = UIImage(named: "active")!
        static var inActive = UIImage(named: "inActive")!
    }
    
    struct Tracking {
        static var empty = UIImage(named: "empty")!
        static var arrow = UIImage(named: "Arrow")!
        static var map   = UIImage(named: "trackingMap")!
        static var car   = UIImage(named: "Car")!
        
        static var avatar   = UIImage(named: "avatar")!
        
        static var start = UIImage(named: "Start")!
        
        static var end = UIImage(named: "End")!
        
        static var stop = UIImage(named: "Stop")!
        
        static var distance = UIImage(named: "Distance")!
        
        static var lostGPS = UIImage(named: "LostGPS")!
        
        static var receivedGPS = UIImage(named: "ReceivedGPS")!
        
        static var lostGSM = UIImage(named: "LostGSM")!
        
        static var receivedGSM = UIImage(named: "ReceivedGSM")!
        
        static var play = UIImage(named: "Play")!
        
        static var pause = UIImage(named: "Pause")!
        
        static var trackingCar = UIImage(named: "TrackingCar")!
        
        static var arrowRight = UIImage(named: "Tracking_ArrowRight")!
    }
    
    struct Help {
        static var Terms: UIImage { return UIImage(named: "Terms")! }
        
        static var Tracking: UIImage { return UIImage(named: "Help_Tracking")! }
    }
    
    /// Icon các Items cho TabBar Chính
    struct TabBar {
        
        static var history: UIImage { return UIImage(named: "TabBarHistory")! }
        
        static var article: UIImage { return UIImage(named: "TabBarArticle")! }
        
        static var noteBook: UIImage { return UIImage(named: "TabBarNoteBook")! }
        
        static var personal: UIImage { return UIImage(named: "TabBarPersonal")! }
    }
    
    struct Personal {
        
        static var AvatarDefault: UIImage { return UIImage(named: "AvatarDefault")! }
        
        static var ChangedPassword: UIImage { return UIImage(named: "ChangedPassword")! }
        
        static var Feedback: UIImage { return UIImage(named: "Feedback")! }
        
        static var Logout: UIImage { return UIImage(named: "Logout")! }
    }

}
