//
//  PasscodeViewController.swift
//  AmdCash
//
//  Created by Gev on 05.08.21.
//

import UIKit

class BioMetricAuthenticator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "BioMetricAuthenticator") { [weak self] (result) in

            switch result {
            case .success( _):

                // authentication successful
                self?.showLoginSucessAlert()

            case .failure(let error):

                switch error {

                // device does not support biometric (face id or touch id) authentication
                case .biometryNotAvailable:
                    self?.showErrorAlert(message: error.message())

                // No biometry enrolled in this device, ask user to register fingerprint or face
                case .biometryNotEnrolled:
                    self?.showGotoSettingsAlert(message: error.message())

                // show alternatives on fallback button clicked
                case .fallback:
                    self?.txtUsername.becomeFirstResponder() // enter username password manually

                // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
                case .biometryLockedout:
                    self?.showPasscodeAuthentication(message: error.message())

                // do nothing on canceled by system or user
                case .canceledBySystem, .canceledByUser:
                    break

                // show error for any other reason
                default:
                    self?.showErrorAlert(message: error.message())
                }
            }
        }

        // Do any additional setup after loading the view.
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
