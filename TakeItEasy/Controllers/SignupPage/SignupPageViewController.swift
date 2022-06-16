//
//  SignupPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import UIKit

class SignupPageViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var otpPopupErrorText: UILabel!
    @IBOutlet weak var otpPopup: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var box1: UIView!
    
    var currentOTP = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        signInButton.isHidden = true
        otpPopup.isHidden = true
        otpPopup.layer.cornerRadius = 10
        otpPopup.layer.masksToBounds = true
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize() {
        roundedCorners(&box1)
        roundedCorners(&otpPopup)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
    
    @IBAction func getOTP(_ sender: Any) {
        var status = false
        
        // error handling
        do {
            try validateSignUpCredentials(userid: userid.text!, email: email.text!, password: password.text!, confirmPassword: confirmPassword.text!, mobileNo: mobileNo.text!)
            status = true
        }
        catch SignupErrors.invalidUserId {
            errorLabel.text = SignupConstants.invalidUserId.rawValue
        }
        catch SignupErrors.invalidEmail {
            errorLabel.text = SignupConstants.invalidEmail.rawValue
        }
        catch SignupErrors.invalidPassword {
            errorLabel.text = SignupConstants.invalidPassword.rawValue
        }
        catch SignupErrors.invalidConfirmPassword {
            errorLabel.text = SignupConstants.invalidConfirmPassword.rawValue
        }
        catch SignupErrors.invalidMobileNo {
            errorLabel.text = SignupConstants.invalidMobileNo.rawValue
        }
        catch {
            errorLabel.text = SignupConstants.unknownSignUpError.rawValue
        }
        
        // MARK: - add user to database code here
        if (status) {
            let existingUser = DBHelperClass.dbHelper.userExists(userid: userid.text!)
            if (existingUser) {
                errorLabel.text = SignupConstants.duplicateEntry.rawValue
                return
            } else {
                startOTPProcess()
            }
            
        }
    }
    
    func createUser(){
        // IMPORTANT: - NEED TO HANDLE DUPLICATE ENTRY ERROR
        errorLabel.text = SignupConstants.registered.rawValue
        DBHelperClass.dbHelper.addUser(userid: userid.text!, password: password.text!)
        print("user successfully signed up")
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        //presumably this should take you to tab controller
        print("otp is confirmed")
    }
    
    func startOTPProcess(){
        currentOTP = getRandomOTP()
        sendOTPNotification()
        otpTextField.text = ""
        otpPopup.isHidden = false
    }
    
    func getRandomOTP() -> String{
        let randomInt = Int.random(in: 0..<9999)
        var otp = String(randomInt)
        
        switch otp.count{
        case 1:
            otp = "000" + otp
        case 2:
            otp = "00" + otp
        case 3:
            otp = "0" + otp
        default:
            break
        }
        return otp
    }
    
    func sendOTPNotification(){
        UNUserNotificationCenter.current().getNotificationSettings{
            notify in
            switch notify.authorizationStatus{
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){granted, err in
                    if let error = err{
                        print(error)
                    }
                    self.generateOtpNotification()
                }
            case .authorized:
                self.generateOtpNotification()
            case .denied:
                print("permission not given")
            default:
                print("")
            }
        }
    }
    
    func generateOtpNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Confirm Sign Up"
        content.subtitle = "for TakeItEasy"
        content.body = "your otp is " + currentOTP
        let timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        let request = UNNotificationRequest(identifier: "Local_Not", content: content, trigger: timeInterval)
        UNUserNotificationCenter.current().add(request){(error : Error?) in
            if let err = error {
                print(err)
            }
        }
    }
    
    @IBAction func submitOTP(_ sender: Any) {
        if isOTPCorrect(){
            createUser()
            signInButton.isHidden = false
            otpPopup.isHidden = true
            otpPopupErrorText.text = ""
            print("otp matches")
        }
        else{
            otpPopupErrorText.text = "OTP does not match"
            print("otp doesn't match")
        }
    }
    
    
    
    @IBAction func closeOTPPopup(_ sender: Any) {
        otpPopupErrorText.text = ""
        otpPopup.isHidden = true
        print("otp closed")
    }
    
    func isOTPCorrect() -> Bool{
        if currentOTP == otpTextField.text{
            return true
        }
        return false
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}


