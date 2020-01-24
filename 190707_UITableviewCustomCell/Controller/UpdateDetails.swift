//
//  UpdateDetails.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 02/01/20.
//  Copyright © 2020 Ankam Ajay Kumar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CoreData
import Toast_Swift

class UpdateDetails: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    //MARK:- IBOutlet
    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var ageTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumberTF: SkyFloatingLabelTextField!
    @IBOutlet weak var selectedImage: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
        
    //Instance Creation
    var pickerImage = UIImagePickerController()
    var imageData = NSData()
    var entityDescription:NSEntityDescription!
    var alert = UIAlertController()
    var OKAction = UIAlertAction()
        
    //MARK:- IBAction
    @IBAction func resetActionBtn(_ sender: UIButton) {
        sender.pulseButton()
        resetData()
    }
      
    @IBAction func updateActionBtn(_ sender: UIButton) {
        sender.pulseButton()
        
    }
    @IBAction func selectedActionImage(_ sender: UIButton) {
        sender.pulseButton()
        pickerImage.sourceType = .savedPhotosAlbum
        pickerImage.allowsEditing = true
        pickerImage.delegate = self
        present(pickerImage, animated: true, completion: nil)
    }
        
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setInObjCreation()
        selectedImage.layer.cornerRadius = selectedImage.frame.size.width/2
        selectedImage.clipsToBounds = true
        selectedImage.layer.borderWidth = 1
        selectedImage.layer.borderColor = #colorLiteral(red: 0.3437103426, green: 0.03938249182, blue: 0.07547473476, alpha: 1)
    }
        
    //MARK:- Method Creation
    //method for TextField layout with parameters
    func setInTextFieldColor(textField:SkyFloatingLabelTextField, placeholder:String, title:String, tintColor:UIColor, textColor:UIColor, lineColor:UIColor, selectedTitleColor:UIColor, selectedLineColor:UIColor)
    {
        textField.placeholder = placeholder
        textField.title = title
        textField.tintColor = tintColor
        textField.textColor = textColor
        textField.delegate = self
        textField.lineColor = lineColor
        textField.selectedTitleColor = selectedTitleColor
        textField.selectedLineColor = selectedLineColor
    }
        
    //method for objects creation
    func setInObjCreation()
    {
        //calling 'setInTextFieldLayout' method for 'Name' TextField
        setInTextFieldColor(textField: nameTF, placeholder: "Name", title: "Enter Your Name", tintColor: UIColor.black, textColor: UIColor.black, lineColor: #colorLiteral(red: 0.3333333433, green: 0.1076081497, blue: 0.1290494415, alpha: 1), selectedTitleColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), selectedLineColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
            
        //calling 'setInTextFieldLayout' method for 'Age' TextField
        setInTextFieldColor(textField: ageTF, placeholder: "Age", title: "Enter Your Age", tintColor: UIColor.black, textColor: UIColor.black, lineColor: #colorLiteral(red: 0.3333333433, green: 0.1076081497, blue: 0.1290494415, alpha: 1), selectedTitleColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), selectedLineColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
            
        //calling 'setInTextFieldLayout' method for 'Mobile Number' TextField
        setInTextFieldColor(textField: mobileNumberTF, placeholder: "Mobile Number", title: "Enter Your Mobile Number", tintColor: UIColor.black, textColor: UIColor.black, lineColor: #colorLiteral(red: 0.3333333433, green: 0.1076081497, blue: 0.1290494415, alpha: 1), selectedTitleColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), selectedLineColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
    }
        
    //creating method for Alert Message
    func myAlertMessage(alertMsg:String)
    {
        alert = UIAlertController(title: "Alert", message: alertMsg, preferredStyle: UIAlertController.Style.alert)
            
        OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
        
    //method to reset
    func resetData()
    {
        nameTF.text = ""
        mobileNumberTF.text = ""
        ageTF.text = ""
    }
        
    //Method to save data
    func updateData()
    {
        if((nameTF.text?.isEmpty)! || (mobileNumberTF.text?.isEmpty)! || (ageTF.text?.isEmpty)!)
        {
            myAlertMessage(alertMsg: "All fields are required 😇")
        }
        else if(isValidName(nameStr: nameTF.text!) == false)
        {
            myAlertMessage(alertMsg: "Invalid Name 😇")
        }
        else if(isValidAge(ageStr: ageTF.text!) == false)
        {
            myAlertMessage(alertMsg: "Invalid Age 😇")
        }
        else if(isValidMobile(mobileStr: mobileNumberTF.text!) == false)
        {
            myAlertMessage(alertMsg: "Invalid Mobile Number (start with 6,7,8,9 & should be 10 char 😇")
        }
        else
        {
            entityDescription = NSEntityDescription.entity(forEntityName: "Adddetails", in: SingletonData.shared.moc)
            
            let addDetails = NSManagedObject.init(entity: entityDescription, insertInto: SingletonData.shared.moc)
            addDetails.setValue(nameTF.text!, forKey: "name")
            addDetails.setValue(Int16(ageTF.text!), forKey: "age")
            addDetails.setValue(mobileNumberTF.text!, forKey: "mobile")
            addDetails.setValue(imageData, forKey: "profilepic")
            
            if(segmentedControl.selectedSegmentIndex == 0)
            {
                addDetails.setValue("Actor", forKey: "selectedSC")
            }
            else if(segmentedControl.selectedSegmentIndex == 1)
            {
                addDetails.setValue("Cricketer", forKey: "selectedSC")
            }
            else
            {
                addDetails.setValue("Politician", forKey: "selectedSC")
            }
            alert = UIAlertController(title: "Well Done!", message: "Details Saved Successfuly😎 ", preferredStyle: UIAlertController.Style.alert)
            OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (save) in
                do
                {
                try SingletonData.shared.moc.save()
                self.navigationController?.popViewController(animated: true)
                    print("Data Saved Successfully")
                }
                catch
                {
                    print("Unable to save data", error.localizedDescription)
                }
            })
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    //MARK:- Regular Expression
    //to check validation with regular expression for 'Name'
    func isValidName(nameStr:String) -> Bool
    {
        let nameRegEx = "[A-Za-z ]{3,64}"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: nameStr)
    }
        
    //to check validation with regular expression for 'Email'
    func isValidAge(ageStr:String) -> Bool {
        let ageRegEx = "[0-9]{1,2}"
        let agePred = NSPredicate(format:"SELF MATCHES %@", ageRegEx)
        return agePred.evaluate(with: ageStr)
    }
        
    //to check validation with regular expression for 'Mobile Number'
    func isValidMobile(mobileStr:String) -> Bool {
        let mobileRegEx = "^[6-9]{1}[0-9]{9}$" //
        let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: mobileStr)
    }
        
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        if let selectedImageInfo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            selectedImage.setImage(selectedImageInfo, for: UIControl.State.normal)
            selectedImage.contentMode = .scaleAspectFit
            imageData = selectedImageInfo.pngData() as! NSData
        }
        dismiss(animated: true, completion: nil)
    }
        
    //MARK:- TextField Delegate Methods
    //creating delegate method for Begin TextField Editing validation
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        var returnValueTextField:Bool = false
            
        if(textField == nameTF)
        {
            returnValueTextField = true
                   
        }
        else if(textField == ageTF)
        {
            if((nameTF.text?.count)! >= 1)
            {
                returnValueTextField = true
                        
            }
            else
            {
                self.contentView.hideAllToasts()
                self.contentView.makeToast("Name field is required", duration: 4.0, position: .top)
            }
        }
        else if(textField == mobileNumberTF)
        {
            if((ageTF.text?.count)! >= 1)
            {
                returnValueTextField = true
            }
            else
            {
                self.contentView.hideAllToasts()
                self.contentView.makeToast("Age field is required", duration: 4.0, position: .top)
            }
        }
        return returnValueTextField
    }
        
    //creating delegate method for TextField End Editing validation using regular expression methods
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            
        var validateReturnValue:Bool = true
            
        if(textField == nameTF)
        {
            if(isValidName(nameStr: textField.text!))
            {
                validateReturnValue = isValidName(nameStr: textField.text!)
            }
            else
            {
                self.view.hideAllToasts()
                self.view.makeToast("Invalid Name", duration: 4.0, position: .top)
            }
        }
        else if(textField == ageTF)
        {
            if(isValidAge(ageStr: textField.text!))
            {
                validateReturnValue = isValidAge(ageStr: textField.text!)
            }
            else
            {
                self.view.hideAllToasts()
                self.view.makeToast("Invalid Age", duration: 4.0, position: .top)
            }
        }
        else if(textField == mobileNumberTF)
        {
            if(isValidMobile(mobileStr: textField.text!))
            {
                validateReturnValue = isValidMobile(mobileStr: textField.text!)
            }
            else
            {
                self.view.hideAllToasts()
                self.view.makeToast("Invalid Mobile Number", duration: 4.0, position: .top)
                }
        }
            
        return validateReturnValue
    }
        
    //creating delegate method to 'Allow or Doesn't Allow characters'
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        var rangeReturnValue:Bool = false
        let allowedChar = CharacterSet(charactersIn: "0123456789") //to allow char
        let notAllowedChar = CharacterSet(charactersIn: "0123456789").inverted //doesn't allow char
            
        if(textField == nameTF)
        {
            if(string.rangeOfCharacter(from: notAllowedChar) != nil || string == "")
            {
                rangeReturnValue = true
            }
        }
        else if(textField == ageTF)
        {
            if(string.rangeOfCharacter(from: allowedChar) != nil || string == "")
            {
                rangeReturnValue = true
            }
        }
        else if(textField == mobileNumberTF)
        {
            if(string.rangeOfCharacter(from: allowedChar) != nil || string == "")
            {
                rangeReturnValue = true
            }
        }
        return rangeReturnValue
    }

}
