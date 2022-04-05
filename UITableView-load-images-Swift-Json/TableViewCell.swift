//
//  TableViewCell.swift
//  UITableView-load-images-Swift-Json
//
//  Created by Luccas Santana Marinho on 04/04/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let img: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let namelbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.contentMode = .scaleAspectFill
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let descriptionlbl: UILabel = {
        let desc = UILabel(frame: .zero)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.contentMode = .scaleAspectFill
        desc.font = UIFont.systemFont(ofSize: 14)
        desc.textColor = .gray
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        return desc
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(img)
        contentView.addSubview(namelbl)
        contentView.addSubview(descriptionlbl)
        
        img.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        img.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        namelbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        namelbl.leadingAnchor.constraint(equalTo: self.img.trailingAnchor, constant: 10).isActive = true
        namelbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        namelbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
        descriptionlbl.topAnchor.constraint(equalTo: self.img.topAnchor, constant: 17).isActive = true
        descriptionlbl.leadingAnchor.constraint(equalTo: self.img.trailingAnchor, constant: 10).isActive = true
        descriptionlbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        descriptionlbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
    
    var data: listData? {
        didSet {
            guard let data = data else {
                return
            }
            namelbl.text = data.name
            descriptionlbl.text = data.description
            img.image = data.image
        }
    }
}
