//
//  MovieListViewController.swift
//  DynamicTableViewCell
//
//  Created by MCT on 20.12.2021.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {

    // MARK: Views

    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(
            MovieListTableViewCell.self,
            forCellReuseIdentifier: cellID
        )
        tableView.dataSource = self
        return tableView
    }()

    // MARK: Properties

    private let viewModel: MovieListViewModelType = MovieListViewModel()
    private var movieDetails: [MovieDetail]?
    private let cellID = String(describing: MovieListTableViewCell.self)

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieDetails = viewModel.getMovies()
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 200
        setUpView()
    }

    // MARK: Private Funcs

    private func setUpView() {
        title = "No Way Home"
        view.addSubview(moviesTableView)

        moviesTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movieDetails?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellID,
            for: indexPath
        ) as? MovieListTableViewCell else { return UITableViewCell() }

        if let movieDetail = movieDetails?[indexPath.row] {
            return cell.configure(movieDetail: movieDetail)
        }

        return UITableViewCell()
    }
}
