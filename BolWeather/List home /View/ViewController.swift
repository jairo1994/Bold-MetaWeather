//
//  ViewController.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = LocationViewModel()
    var gestureTouch = UITapGestureRecognizer()
    private let identifier = "LocationTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Type to look for"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.delegate = self
        searchBar.placeholder = "Something like Mexico"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        self.gestureTouch = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        
        viewModel.didFetchLocation = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    @objc func closeKeyboard(){
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(gestureTouch)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LocationTableViewCell,
              let location = viewModel.getInfoByIndex(index: indexPath.section) else{
            return UITableViewCell()
        }
        
        let v = UIView()
        v.backgroundColor = .clear
        cell.selectedBackgroundView = v
        
        cell.configViewBy(location, searchBarText: searchBar.text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.getInfoByIndex(index: indexPath.section) else {
            return
        }
        self.navigationController?.pushViewController(DetailViewController(viewModel: DetailViewModel(location.woeid)), animated: true)
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.addGestureRecognizer(gestureTouch)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            
        }else{
            
            viewModel.lookFor(searchText)
            
            
        }
    }
}
