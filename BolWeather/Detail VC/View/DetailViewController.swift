//
//  DetailViewController.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var loadingStack: UIStackView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailViewModel!
    private let identifier = "DayInfoTableViewCell"
    private let sourceIdentifier = "SourceTableViewCell"
    
    init(viewModel: DetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alpha = 0
        loadingStack.alpha = 1
        tryAgainButton.alpha = 0
        
        viewModel.fetchDetailInfo()
        
        viewModel.didFetchLocation = { [weak self] ready in
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                
                if ready {
                    self?.tableView.alpha = 1
                    self?.loadingStack.alpha = 0
                    self?.tableView.reloadData()
                    self?.loadInfo()
                    self?.tableView.reloadData()
                }else{
                    self?.tableView.alpha = 0
                    self?.activity.alpha = 0
                    self?.loadingLabel.text = "Something went wrong"
                    self?.tryAgainButton.alpha = 1
                    self?.tableView.reloadData()
                    self?.loadInfo()
                    self?.tableView.reloadData()
                }
            }
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.register(UINib(nibName: sourceIdentifier, bundle: nil), forCellReuseIdentifier: sourceIdentifier)
        // Do any additional setup after loading the view.
    }

    func loadInfo(){
        self.title = viewModel.detail.title
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        activity.alpha = 1
        loadingLabel.text = "Cargando detalle..."
        loadingStack.alpha = 1
        tableView.alpha = 0
        tryAgainButton.alpha = 0
        viewModel.fetchDetailInfo()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.detail.consolidated_weather.count
        }else{
            return viewModel.detail.sources.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let view = TopInfoView()
            view.configView(detail: viewModel.detail)
            
            return view
        }else{
            let label = UILabel()
            label.text = "Sources"
            label.font = UIFont.boldSystemFont(ofSize: 24)
            
            return label
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 151
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 65
        }else{
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DayInfoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.config(info: viewModel.detail.consolidated_weather[indexPath.item])
            cell.backgroundColor = Colors.blackWhite.color
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sourceIdentifier) as? SourceTableViewCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            cell.backgroundColor = Colors.blackWhite.color
            cell.config(source: viewModel.detail.sources[indexPath.item])
            
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       
//        
//        if let viewHeader = self.tableView.headerView(forSection: 0) as? TopInfoView {
//            viewHeader.configView(detail: viewModel.detail, selectedDay: indexPath.item)
//        }
//    }
}

extension DetailViewController: OpenSourceProtocol{
    func openSource(link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}

protocol OpenSourceProtocol {
    func openSource(link: String)-> Void
}
