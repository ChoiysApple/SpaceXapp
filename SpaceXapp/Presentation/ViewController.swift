//
//  ViewController.swift
//  SpaceXapp
//
//  Created by Daegeon Choi on 2022/05/16.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let id = "tableViewCell"
    
    //MARK: Instances
    lazy var tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: self.id)
        $0.allowsSelection = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        configureUI()
        
        viewModel.requestData()
    }
    
    private func configureUI() {
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func bindData() {

        _ = viewModel.launchObservable.bind(to: tableView.rx.items(cellIdentifier: id)) {
            index, model, cell in
        
            cell.textLabel?.text = "[\(model.id)] \(model.site!)"
        }
    }

}
