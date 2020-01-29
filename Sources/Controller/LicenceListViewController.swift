//
//  LicenceListViewController.swift
//  OpenSourceControllerDemo
//
//  Created by Florian Gabach on 23/10/2018.
//  Copyright © 2018 OpenSourceController. All rights reserved.
//

#if !os(macOS)
import UIKit
#else
import AppKit
#endif

open class LicenceListViewController: UITableViewController {
    
    // MARK: - Var
    
    fileprivate var config: OpenSourceControllerConfig

    fileprivate var downloadedLicence: [LicenceFile]
    
    // MARK: - Lifecyle
    
    init(downloadedLicence: [LicenceFile], config: OpenSourceControllerConfig) {
        self.config = config
        self.downloadedLicence = downloadedLicence
        super.init(style: .plain)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
    }
    
    // MARK: - Prepare
    
    fileprivate func prepareTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cellType: OpenSourceTableViewCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundColor = self.config.uiConfig.backgroundColor
    }
}
    
extension LicenceListViewController {
    
    // MARK: - Table View Data Source
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.downloadedLicence.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OpenSourceTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let licence = self.downloadedLicence.get(at: indexPath.row) else { return cell }
        cell.configure(licence: licence, config: self.config)
        return cell
    }
    
    override open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
