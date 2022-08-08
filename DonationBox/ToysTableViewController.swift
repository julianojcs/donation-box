//
//  ToysTableViewController.swift
//  DonationBox
//
//  Created by Juliano Costa Silva on 03/08/22.
//

import UIKit
import Firebase

class ToysTableViewController: UITableViewController {
    
    let collection = "toys"
    var toys: [Toy] = []
    lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        listener = firestore.collection(collection).order(by: "name", descending: false).addSnapshotListener(includeMetadataChanges: true, listener:  { snapshot, error in
            if let error = error {
                print(error)
            } else {
                guard let snapshot = snapshot else {
                    return
                }
                print("Total de documentos alterados: \(snapshot.documentChanges.count)")
                if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0 {
                    self.showItemsFrom(snapshot)
                }
            }
        })
    }
    
    func showItemsFrom(_ snapshot: QuerySnapshot) {
        toys.removeAll()
        toys = snapshot.documents.map { doc in
            return Toy(
                id: doc.documentID,
                name: doc["name"] as? String ?? "",
                status: doc["status"] as? Int ?? 0,
                donorName: doc["donorName"] as? String ?? "",
                donorAddress: doc["donorAddress"] as? String ?? "",
                donorPhone: doc["donorPhone"] as? String ?? ""
            )
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toyFormViewController = segue.destination as? ToyFormViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            toyFormViewController.toy = toys[row]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let toy = toys[indexPath.row]
        cell.textLabel?.text = toy.name
        cell.detailTextLabel?.text = toy.toyStatus

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toy = toys[indexPath.row]
            firestore.collection(collection).document(toy.id!).delete(completion: { error in
                if let _ = error {
                    print("Deleting error!")
                }
            })
        }
    }
}
