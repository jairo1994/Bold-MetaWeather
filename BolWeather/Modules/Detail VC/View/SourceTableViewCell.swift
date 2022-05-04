//
//  SourceTableViewCell.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var nameSource: UILabel!
    @IBOutlet weak var openSource: UIButton!
    var source: SourcesDetail!
    var delegate: OpenSourceProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(source: SourcesDetail){
        self.source = source
        nameSource.text = source.title
    }
    
    
    @IBAction func openSource(_ sender: Any) {
        delegate.openSource(link: source.url)
    }
    
}
