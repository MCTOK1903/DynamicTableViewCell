//
//  MovieListTableViewCell.swift
//  DynamicTableViewCell
//
//  Created by MCT on 20.12.2021.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {

    // MARK: Views

    private let parentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        stack.axis = .vertical
        return stack
    }()

    let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        return image
    }()

    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    // MARK: - init

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    // MARK: Private Funcs

    private func setUpView() {
        contentView.addSubview(parentStack)

        parentStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.trailing.equalTo(contentView).inset(8)
        }
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(movieImage.snp.width).multipliedBy(1.5/1)
        }
        parentStack.addArrangedSubview(movieImage)
        parentStack.addArrangedSubview(movieNameLabel)
        parentStack.addArrangedSubview(descriptionLabel)
    }

    // MARK: Public Funcs

    func configure(movieDetail: MovieDetail) -> MovieListTableViewCell {
        if let path = movieDetail.posterPath {
            movieImage.kf.setImage(
                with: URL(
                    string: Constant.NetworkConstant.imagePath + path
                )
            )
        }

        movieNameLabel.text = movieDetail.title
        descriptionLabel.text = movieDetail.overview
        
        selectionStyle = .none
        return self
    }
}
