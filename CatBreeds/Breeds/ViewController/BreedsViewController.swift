//
//  BreedsViewController.swift
//  CatBreeds
//
//  Created by Yash on 29/11/23.
//
import UIKit

class BreedsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = BreedsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell)
        viewModel.getBreeds()
    }
    
}

extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.breedCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell, for: indexPath) as? ImageTitleSubTitleTableViewCell else {return UITableViewCell()}
        
        guard let cellViewModel = viewModel.getCellViewModel(at: indexPath.row) else {return cell}
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVM = viewModel.getDetailViewModel(at: indexPath.row) else {return}
        let storyboard = UIStoryboard.breedsStoryBoard
        let vc = storyboard.instantiateViewController(identifier: Constants.StoryBoardIdentifiers.BreedScreens.ViewControllerIdentiers.BreedDetailViewController) {coder in
            return BreedDetailViewController(coder: coder, viewModel: detailVM)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BreedsViewController: BreedsViewModelDelegate {
    func reloadImageView(at index: Int) {
        guard let cell = self.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? ImageTitleSubTitleTableViewCell else {return}
        cell.reloadImageView()
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func showError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: false)
    }
}


