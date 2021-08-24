//
//  HistoryViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 22/8/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
  }
  
  struct Session {
    let date: String
    let duration: String
    let notes: String?
  }
  
  var sessions = [Session(
                    date: "12 May 21 - 12:00 am",
                    duration: "25 minutes",
                    notes: ""),
                  Session(
                    date: "10 May 21 - 12:00 am",
                    duration: "3 hours 12 minutes 32 seconds",
                    notes: "")]
  
  private func createView() {
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    view.addSubview(blurredBackgroundView)
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.estimatedRowHeight = 300
    
    tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.95).isActive = true
    tableView.backgroundColor = .clear
    
    tableView.dataSource = self
    tableView.register(HistoryCell.self, forCellReuseIdentifier: "historyCell")
    tableView.separatorStyle = .none
  }
}

extension HistoryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryCell else {
      return UITableViewCell()
    }
    
    cell.session = sessions[indexPath.row]
    
    if let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate) {
      
      let disclosureImageView = UIImageView(
        frame: CGRect(
          x: 0,
          y: 0,
          width: image.size.width,
          height: image.size.height
        )
      )
      
      disclosureImageView.tintColor = .white
      disclosureImageView.image = image
      cell.accessoryView = disclosureImageView
    }
    
    return cell
  }
  
}
