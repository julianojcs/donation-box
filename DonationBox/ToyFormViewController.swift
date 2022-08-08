//
//  ToyFormViewController.swift
//  DonationBox
//
//  Created by Juliano Costa Silva on 03/08/22.
//

import UIKit
import Firebase

class ToyFormViewController: UIViewController {

    @IBOutlet weak var textFieldToyName: UITextField!
    @IBOutlet weak var textFieldDonor: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var segmentedControlToyStatus: UISegmentedControl!
    @IBOutlet weak var stackViewTextFields: UIStackView!
    
    @IBOutlet weak var labelToyName: UILabel!
    @IBOutlet weak var labelToyStatus: UILabel!
    @IBOutlet weak var labelDonor: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var stackViewLabels: UIStackView!
    
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    var toy: Toy?
    let collection: String = "toys"
    var rightButtonText: String = ""
    lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()

    
    func setRightBarButtonStatus( statusMode: String ) {
        if statusMode != "Create" {
            let rightButton = UIBarButtonItem(title: statusMode, style: .plain, target: self, action: #selector(editCancel(_ :)))
            self.navigationItem.rightBarButtonItem  = rightButton
        } else {
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareScreen()
    }
    
    func fillFieldsValues() {
        if let toy = toy {
            textFieldToyName.text = toy.name
            segmentedControlToyStatus.selectedSegmentIndex = toy.status
            textFieldDonor.text = toy.donorName
            textFieldAddress.text = toy.donorAddress
            textFieldPhone.text = toy.donorPhone
        
            labelToyName.text = "Toy: \(toy.name)"
            labelToyStatus.text = "Status: \(toy.toyStatus)"
            labelDonor.text = "Donor: \(toy.donorName)"
            labelAddress.text = "Address: \(toy.donorAddress)"
            labelPhone.text = "Phone: \(toy.donorPhone)"
        }
    }
    
    func prepareEditScreen() {
        rightButtonText = "Edit"
        title = "Toy for Donation"
        setRightBarButtonStatus( statusMode: rightButtonText )
        fillFieldsValues()
        stackViewLabels.isHidden = false
        stackViewTextFields.isHidden = true
        buttonAddEdit.setTitle("Save Edited Donation", for: .normal)
    }
    
    func prepareShowScreen() {
        stackViewLabels.isHidden = true
        stackViewTextFields.isHidden = false
    }
    
    func prepareScreen() {
        if let _ = toy {
            prepareEditScreen()
        } else {
            prepareShowScreen()
        }
    }

    @IBAction func save(_ sender: UIButton) {
        guard let name = textFieldToyName.text,
            let status = segmentedControlToyStatus?.selectedSegmentIndex,
            let donorName = textFieldDonor.text,
            let donorAddress = textFieldAddress.text,
            let donorPhone = textFieldPhone.text else { return }
        let data: [String: Any] = [
            "name": name,
            "status": status,
            "donorName": donorName,
            "donorAddress": donorAddress,
            "donorPhone": donorPhone
        ]
        if let toy = toy {
            self.firestore.collection("toys").document(toy.id!).updateData(data)
        } else {
            self.firestore.collection("toys").addDocument(data: data)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editCancel(_ sender: UIBarButtonItem) {
        fillFieldsValues()
        if rightButtonText == "Edit" {
            rightButtonText = "Cancel"
            setRightBarButtonStatus( statusMode: rightButtonText )
            title = "Edit Toy Donation"
            stackViewLabels.isHidden = true
            stackViewTextFields.isHidden = false
        } else {
            rightButtonText = "Edit"
            setRightBarButtonStatus( statusMode: rightButtonText)
            title = "Toy For Donation"
            stackViewLabels.isHidden = false
            stackViewTextFields.isHidden = true
        }
    }
}
