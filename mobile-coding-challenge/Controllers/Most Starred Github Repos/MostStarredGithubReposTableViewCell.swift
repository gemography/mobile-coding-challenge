//
//  MostStarredGithubReposTableViewCell.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit
import Kingfisher

class MostStarredGithubReposTableViewCell: UITableViewCell {
    
    private let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font          = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private let repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font          = .systemFont(ofSize: 13)
        label.numberOfLines = 3
        return label
    }()
    
    private let repositoryOwnerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "empty-avatar-icon")
        return imageView
    }()
    
    private let repositoryOwnerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let repositoryStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "star_icon")
        return imageView
    }()
    
    private let repositoryNumberOfStarsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let topBottomSpacing      : CGFloat = 20
    private let leadingTrailingSpacing: CGFloat = 30
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createCellViewAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createCellViewAutoLayout()
    }
    
    func fillView(repositoryName: String, repositoryDescription: String, repositoryOwnerImageLink: URL?, repositoryOwnerName: String, repositoryNumberOfStars: String) {
        
        self.repositoryNameLabel.text          = repositoryName
        self.repositoryDescriptionLabel.text   = repositoryDescription
        self.repositoryOwnerNameLabel.text     = repositoryOwnerName
        self.repositoryNumberOfStarsLabel.text = repositoryNumberOfStars
        
        if let _ = repositoryOwnerImageLink{
            self.repositoryOwnerImageView.kf.setImage(with: repositoryOwnerImageLink!)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.repositoryOwnerImageView.image = #imageLiteral(resourceName: "empty-avatar-icon")
        
    }

}

extension MostStarredGithubReposTableViewCell{
    
    private func createCellViewAutoLayout(){
        
        self.contentView.addSubview(self.repositoryNameLabel)
        self.contentView.addSubview(self.repositoryDescriptionLabel)
        self.contentView.addSubview(self.repositoryOwnerImageView)
        self.contentView.addSubview(self.repositoryOwnerNameLabel)
        self.contentView.addSubview(self.repositoryStarImageView)
        self.contentView.addSubview(self.repositoryNumberOfStarsLabel)
        
        NSLayoutConstraint.activate([
        
            self.repositoryNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: self.topBottomSpacing),
            self.repositoryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: self.leadingTrailingSpacing),
            self.repositoryNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -self.leadingTrailingSpacing),
            
            self.repositoryDescriptionLabel.topAnchor.constraint(equalTo: self.repositoryNameLabel.bottomAnchor, constant: 10),
            self.repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: self.leadingTrailingSpacing),
            self.repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -self.leadingTrailingSpacing),
            
            self.repositoryOwnerImageView.topAnchor.constraint(equalTo: self.repositoryDescriptionLabel.bottomAnchor, constant: 10),
            self.repositoryOwnerImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -self.topBottomSpacing),
            self.repositoryOwnerImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: self.leadingTrailingSpacing),
            self.repositoryOwnerImageView.widthAnchor.constraint(equalToConstant: 20.0),
            self.repositoryOwnerImageView.heightAnchor.constraint(equalTo: self.repositoryOwnerImageView.widthAnchor),
            
            self.repositoryOwnerNameLabel.leadingAnchor.constraint(equalTo: self.repositoryOwnerImageView.trailingAnchor, constant: 6),
            self.repositoryOwnerNameLabel.centerYAnchor.constraint(equalTo: self.repositoryOwnerImageView.centerYAnchor),
            
            self.repositoryStarImageView.leadingAnchor.constraint(equalTo: self.repositoryOwnerNameLabel.trailingAnchor, constant: 15),
            self.repositoryStarImageView.centerYAnchor.constraint(equalTo: self.repositoryOwnerImageView.centerYAnchor),
            self.repositoryStarImageView.widthAnchor.constraint(equalToConstant: 15.0),
            self.repositoryStarImageView.heightAnchor.constraint(equalTo: self.repositoryStarImageView.widthAnchor),
            
            self.repositoryNumberOfStarsLabel.leadingAnchor.constraint(equalTo: self.repositoryStarImageView.trailingAnchor, constant: 6),
            self.repositoryNumberOfStarsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -self.leadingTrailingSpacing),
            self.repositoryNumberOfStarsLabel.centerYAnchor.constraint(equalTo: self.repositoryOwnerImageView.centerYAnchor),
            
        ])
        
        self.repositoryNameLabel.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        self.repositoryOwnerNameLabel.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        
    }
    
}
