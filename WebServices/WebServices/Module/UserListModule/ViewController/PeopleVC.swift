//
//  PeopleVC.swift
//  WebServices
//
//  Created by Darshan Dangar on 06/07/23.
//

import UIKit

class PeopleVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tblPeople: UITableView!
    
    // MARK: Variables
    private var listOfPeople: [Datum] = []
    let peopleVm  = PeoopleVm()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: Private Method
    private func initialSetup() {
        tblPeople.delegate = self
        tblPeople.dataSource = self
        bindVM()
        peopleVm.getDatafromServer()
        tblPeople.register(UINib(nibName: Constants.TblCell.tblCellUserList, bundle: nil), forCellReuseIdentifier: Constants.TblCell.tblCellUserList)
    }
    
    private func bindVM() {
        peopleVm.userList.bind { user in
            DispatchQueue.main.async {
                self.tblPeople.reloadData()
            }
        }
    }

}

// MARK: UITableView Delegates
extension PeopleVC: UITableViewDelegate {
    
}

// MARK: UITableView DataSource
extension PeopleVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleVm.userList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TblCell.tblCellUserList, for: indexPath) as? TblCellUserList else {
            return UITableViewCell()
        }
        let dataForParticularIndex = peopleVm.userList.value[indexPath.row]
        cell.configCell(data: dataForParticularIndex)
        return cell
    }
    
    
}



