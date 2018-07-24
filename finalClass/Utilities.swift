//
//  Utilities.swift
//  PetBook
//
//  Created by Moy Hdez on 23/04/18.
//  Copyright © 2018 Luis Perez. All rights reserved.
//
import UIKit
import Foundation

class Utilities{
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func showAlertOk(title:String, message:String)->UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("alertok", comment: ""), style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
    
    class func checkLenghtPassword(pass:String)->Bool{
        return pass.count > 5
    }
    
    class func stringToDate(dateStr:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let goodDate = dateFormatter.string(from: date!)
        return dateFormatter.date(from: goodDate)!
    }
    
    class func getDateWithFormat(date:Date)->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from:date)
    }
    

    
    
    class func getToday() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: Date())
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) > 6) {
            cString = String(cString.prefix(6))
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.99)
        )
    }
    
    class func launchVC(vcFrom:UIViewController,vcTo:UIViewController){
        let transition = CATransition()
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        vcFrom.view.window!.layer.add(transition, forKey: nil)
        UIApplication.shared.keyWindow?.rootViewController = vcTo
        DispatchQueue.main.async{
            transition.duration = 0.35
            vcFrom.dismiss(animated: false, completion: nil)
            vcFrom.present(vcTo, animated: false, completion: nil)
        }
    }
    class func launchFadeVC(vcFrom:UIViewController,vcTo:UIViewController){
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromTop
        vcFrom.view.window!.layer.add(transition, forKey: nil)
        UIApplication.shared.keyWindow?.rootViewController = vcTo
        DispatchQueue.main.async{
            transition.duration = 0.35
            vcFrom.dismiss(animated: false, completion: nil)
            vcFrom.present(vcTo, animated: false, completion: nil)
        }
    }
    
    class func presentVC(vcFrom:UIViewController, vwTo:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        vcFrom.view.window!.layer.add(transition, forKey: nil)
        vcFrom.present(vwTo, animated: false, completion: nil)
        vcFrom.view.window!.rootViewController = vwTo
    }
    
    class func presentFromTopVC(vcFrom:UIViewController, vwTo:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        vcFrom.view.window!.layer.add(transition, forKey: nil)
        vcFrom.present(vwTo, animated: false, completion: nil)
        vcFrom.view.window!.rootViewController = vwTo
    }
    
    class func presentAlertVC(vcFrom:UIViewController, vwTo:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromTop
        vcFrom.view.window!.layer.add(transition, forKey: nil)
        vcFrom.present(vwTo, animated: false, completion: nil)
        vcFrom.view.window!.rootViewController = vwTo
    }
    
    class func dismissVC(vc:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        vc.view.window!.layer.add(transition, forKey: kCATransition)
        vc.dismiss(animated: false, completion: nil)
    }
    
    class func dismissFromAlert(vc:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        vc.view.window?.layer.add(transition, forKey: nil)
        vc.presentingViewController?.view.isHidden = true
        vc.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    class func dismissAlertVC(vc:UIViewController){
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = kCATransitionFade
        vc.view.window!.layer.add(transition, forKey: kCATransition)
        vc.dismiss(animated: false, completion: nil)
    }
    
    class func getAgeDog(birthDate:String)->(Int,Int){
        let now = Date()
        let birthday: Date = Utilities.stringToDate(dateStr: birthDate)
        let calendar = Calendar.current
        let monthsComponents = calendar.dateComponents([.month], from: birthday, to: now)
        let months = monthsComponents.month!
        let age = months%12
        let years = months/12
        return(years,age)
    }
    
    class func addShadowToView(view: Any){
        (view as AnyObject).layer.shadowPath = UIBezierPath(roundedRect:
            (view as AnyObject).bounds, cornerRadius: (view as AnyObject).layer.cornerRadius).cgPath
        (view as AnyObject).layer.shadowColor = UIColor.lightGray.cgColor
        (view as AnyObject).layer.shadowOpacity = 0.3
        (view as AnyObject).layer.shadowOffset = CGSize(width: 3, height: 3)
        (view as AnyObject).layer.shadowRadius = 4
        (view as AnyObject).layer.masksToBounds = false
    }
    
    class func textToRight(texto: UITextField, width: CGFloat){
        texto.leftView = UIView(frame:CGRect(x: 0, y: 0, width: width, height: 10))
        texto.leftViewMode = UITextFieldViewMode.always
    }
    
    class func addBorderColor(vw:AnyObject, width: CGFloat, color: CGColor){
        vw.layer.cornerRadius = 8
        vw.layer.borderWidth = width
        vw.layer.borderColor = color
    }
    
    class func addBorderColorRounded(vw:AnyObject, width: CGFloat, color: CGColor){
        vw.layer.cornerRadius = vw.frame.width/2
        vw.layer.borderWidth = width
        vw.layer.borderColor = color
    }
    
    class func animatePlaceHolderUp(placeHolder:UILabel){
        UIView.animate(withDuration: 0.35, animations: {
            placeHolder.font = UIFont.systemFont(ofSize: 11)
            placeHolder.transform = CGAffineTransform(translationX: 0, y: -18)
            placeHolder.textColor = .lightGray
        },completion:nil)
    }
    
    class func placeHolderReturnPosition(edt:UITextField ,placeHolder: UILabel){
        if edt.text!.count == 0{
            UIView.animate(withDuration: 0.35, animations: {
                placeHolder.font = .systemFont(ofSize: 14)
                placeHolder.transform = CGAffineTransform(translationX: 0, y: 0)
                placeHolder.textColor = .black
            },completion:nil)
        }
    }
    
    class func imageToString(img:UIImage)->String{
        let imageData = UIImageJPEGRepresentation(img, 1)
        return imageData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    class func stringToImage(str:String)->UIImage{
        if let decodedData = Data(base64Encoded: str, options: .ignoreUnknownCharacters) {
            return UIImage(data: decodedData)!
        }else{
            return UIImage()
        }
    }
}
