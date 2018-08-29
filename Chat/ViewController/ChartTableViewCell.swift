//
//  ChartTableViewCell.swift
//  Chat
//
//  Created by NikitaPrakash Patil on 8/26/18.
//  Copyright © 2018 NikitaPrakash Patil. All rights reserved.
//

import UIKit
import Charts
class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var horizontalBarchart: HorizontalBarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var dueLineChart: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
