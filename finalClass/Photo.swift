

import UIKit
import Social

class Photo: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var edtName: UITextField!
    var imageSize: UIImage!
    // primero dar permisos en info.plist de camara y de galeria
    
    @IBAction func clickAddphoto(_ sender: Any) {
        let alertController = UIAlertController(title: "Final", message: NSLocalizedString("necesitamos una foto de tu amigo", comment: ""), preferredStyle: .alert)
        let btnGallery = UIAlertAction(title: NSLocalizedString("tomar de galeria", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in self.selectImage(from: UIImagePickerControllerSourceType.photoLibrary)
        }
        let btnCamera = UIAlertAction(title: NSLocalizedString("hacer una foto", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in self.openCamera(from: UIImagePickerControllerSourceType.camera)
        }
        let btnCancel = UIAlertAction(title: NSLocalizedString("cancelar", comment: ""), style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancelado")
        }
        alertController.addAction(btnGallery)
        alertController.addAction(btnCamera)
        alertController.addAction(btnCancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var imageBase64 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        edtName.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        edtName.becomeFirstResponder()
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == edtName{
            Utilities.animatePlaceHolderUp(placeHolder: lblPlaceholder)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Utilities.placeHolderReturnPosition(edt: textField, placeHolder: lblPlaceholder)
    }
    
  
    
    func selectImage(from source: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerController.sourceType = source
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func openCamera(from source: UIImagePickerControllerSourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = source;
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    //picker de edit image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let base = (info[UIImagePickerControllerEditedImage] as! UIImage)
        let imagen = resizeImage(image: base)
        imageSize = imagen
        self.dismiss(animated: true, completion: nil)
        //imageBase64 = Utilities.imageToString(img: base)
    }
    //escalamos la imagen
    func resizeImage(image: UIImage) -> UIImage? {
        let scale = 200 / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: 200, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: 200, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func postToFacebookTapped(sender: UIButton) {
        if let phoneCallURL = URL(string: "tel://3323849162") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
