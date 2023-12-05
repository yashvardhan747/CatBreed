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
        reloadTableViewData()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefersh), for: .valueChanged)
    }
    
    @objc private func callPullToRefersh() {
        reloadTableViewData()
    }
    
    private func reloadTableViewData() {
        viewModel.fetchBreeds()
    }
    
    deinit {
        BreedImageUrlFetcher.shared.delegates = BreedImageUrlFetcher.shared.delegates.filter { delegate in
            guard delegate is BreedsViewModel else {
                return true
            }
            return false
        }
    }
}
// MARK: - TableView Delegate and DataSource
extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.breedCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.ImageTitleSubTitleTableViewCell, for: indexPath) as? ImageTitleSubTitleTableViewCell else {return UITableViewCell()}
        
        guard let cellViewModel = viewModel.getCellViewModel(at: indexPath.row) else {return cell}
        cell.delegate = self
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

//MARK: - BreedsViewModelDelegate
extension BreedsViewController: BreedsViewModelDelegate {
    func reloadTableView(at index: Int) {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    func reloadTableView() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func showError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .cancel) { _ in
            self.tableView.refreshControl?.endRefreshing()
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.contentOffset = CGPoint.zero
            })
        }
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: false)
        self.tableView.refreshControl?.endRefreshing()
    }
}

extension BreedsViewController: ImageTitleSubTitleTableViewCellDelegate {
    func reloadImageView(for index: Int) {
        viewModel.reloadImageUrl(for: index)
    }
}

